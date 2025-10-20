//
//  OnboardingSlideshow.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2022-09-04.
//  Copyright © 2022-2024 Kankoda. All rights reserved.
//

import Combine
import SwiftUI

/// This slideshow slides through a set of onboarding slide views, with support for
/// navigating with swipes, arrow keys, and edge taps.
///
/// This view can be styled with ``SwiftUI/View/onboardingSlideshowStyle(_:)``.
public struct OnboardingSlideshow<PageModel, Page: View>: View {

    /// Create an onboarding slideshow.
    ///
    /// - Parameters:
    ///   - pages: The pages to present.
    ///   - pageIndex: The current page index.
    ///   - config: The configuration to use, by default `.standard`.
    ///   - onStoryCompleted: The action to trigger at the end.
    ///   - content: A page content builder function.
    public init(
        pages: [PageModel],
        pageIndex: Binding<Int>,
        onStoryCompleted: @escaping () -> Void,
        @ViewBuilder content: @escaping PageBuilder
    ) {
        self.pages = pages
        self._pageIndex = pageIndex
        self.onStoryCompleted = onStoryCompleted
        self.content = content
    }

    public typealias PageInfo = OnboardingPageInfo<PageModel>
    public typealias PageBuilder = (PageInfo) -> Page

    private let pages: [PageModel]
    private let onStoryCompleted: () -> Void
    private let content: PageBuilder

    @Binding private var pageIndex: Int

    @Environment(\.onboardingSlideshowConfiguration)
    private var config

    public var body: some View {
        _OnboardingSlideshow(
            pages: pages,
            pageIndex: $pageIndex,
            config: config,
            onStoryCompleted: onStoryCompleted,
            content: content
        )
    }
}

private struct _OnboardingSlideshow<PageModel, Content: View>: View {

    /// Create an onboarding slideshow.
    ///
    /// - Parameters:
    ///   - pages: The pages to present.
    ///   - pageIndex: The current page index.
    ///   - config: The configuration to use, by default `.standard`.
    ///   - onStoryCompleted: The action to trigger at the end.
    ///   - content: A page content builder function.
    init(
        pages: [PageModel],
        pageIndex: Binding<Int>,
        config: OnboardingSlideshowConfiguration = .standard,
        onStoryCompleted: @escaping () -> Void,
        @ViewBuilder content: @escaping ContentBuilder
    ) {
        self.pages = pages
        self._pageIndex = pageIndex
        self.config = config
        self.onStoryCompleted = onStoryCompleted
        self.content = content
        self.timer = Timer.publish(
            every: config.slideDuration * config.timerTickIncrement,
            on: .main,
            in: .common
        )
        .autoconnect()
    }

    typealias PageInfo = OnboardingPageInfo<PageModel>
    typealias ContentBuilder = (PageInfo) -> Content

    let pages: [PageModel]
    let config: OnboardingSlideshowConfiguration
    let timer: Publishers.Autoconnect<Timer.TimerPublisher>
    let onStoryCompleted: () -> Void
    let content: ContentBuilder

    @Binding var pageIndex: Int

    @Environment(\.onboardingSlideshowStyle) var style

    @State var currentProgress = 0.0
    @State var isTimerRunning = true

    var body: some View {
        ZStack(alignment: .top) {
            progressViews
            slideshow
        }
        .onReceive(timer) { _ in
            guard isTimerRunning else { return }
            handleTimerTick()
        }
    }
}

// MARK: - Views

private extension _OnboardingSlideshow {

    var progressViews: some View {
        #if os(tvOS)
        progressViewsContent
        #else
        progressViewsContent
            .buttonStyle(.borderless)
        #endif
    }
    
    var progressViewsContent: some View {
        HStack {
            ForEach(0..<pages.count, id: \.self) { index in
                Button {
                    setNewIndex(index)
                } label: {
                    progressView(index)
                }
            }
        }
        .padding(.horizontal)
    }
    
    var slideshow: some View {
        #if os(iOS) || os(visionOS)
        TabView(selection: $pageIndex) {
            ForEach(
                Array(pages.enumerated()),
                id: \.offset,
                content: content
            )
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                HStack(spacing: 0) {
                    stepper(next: false)
                    stepper(next: true)
                }
            )
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        #else
        PageView(
            pages: Array(pages.enumerated()),
            currentPageIndex: $pageIndex,
            pageIndicatorDisplayMode: .never,
            pageIndicatorStyle: .standard
        ) { page in
            content(for: page)
        }
        #endif
    }

    func content(
        for info: EnumeratedSequence<[PageModel]>.Element
    ) -> some View {
        content(
            .init(
                page: info.element,
                pageIndex: info.offset,
                currentPageIndex: $pageIndex,
                totalPageCount: pages.count
            )
        )
        .tag(info.offset)
    }

    func progressView(_ slideIndex: Int) -> some View {
        OnboardingSlideshowProgressView(
            index: slideIndex,
            slideshowIndex: pageIndex,
            slideshowProgress: currentProgress
        )
        .padding(.vertical)
        .contentShape(Rectangle())
    }
    
    func stepper(next: Bool) -> some View {
        #if os(tvOS)
        Color.clear
        #else
        Color.clear
            .contentShape(Rectangle())
            .accessibilityLabel(Text(
                next ? config.nextAccessibilityLabel : config.previousAccessibilityLabel))
            .onTapGesture {
                next ? moveToNextSlide() : moveToPreviousSlide()
            }
            .onLongPressGesture(
                minimumDuration: 60,
                maximumDistance: 100,
                perform: {},
                onPressingChanged: {
                    isTimerRunning = !$0
                }
            )
        #endif
    }
}

// MARK: - Slide Controls

private extension _OnboardingSlideshow {

    var isFullProgress: Bool {
        currentProgress >= 1
    }
    
    func endSlides() {
        currentProgress = 1
        isTimerRunning = false
        onStoryCompleted()
    }
    
    func handleTimerTick() {
        if isFullProgress { return moveToNextSlide() }
        withAnimation {
            let newProgress = currentProgress + config.timerTickIncrement
            currentProgress = min(newProgress, 1)
        }
    }
    
    func moveToNextSlide() {
        let index = pages.index(after: pageIndex)
        guard index < pages.endIndex else { return endSlides() }
        setNewIndex(index)
    }
    
    func moveToPreviousSlide() {
        let index = pages.index(before: pageIndex)
        guard index >= pages.startIndex else { return }
        setNewIndex(index)
    }
    
    func setNewIndex(_ index: Int) {
        withAnimation {
            pageIndex = index
            currentProgress = 0.0
            isTimerRunning = true
        }
    }
}


// MARK: - Preview

#Preview {

    struct Preview: View {

        @State var pageIndex = 0

        var body: some View {
            OnboardingSlideshow(
                pages: Array(0...2),
                pageIndex: $pageIndex,
                onStoryCompleted: handleStoryCompleted,
                content: {
                    PreviewPage(info: $0)
                }
            )
            .onboardingSlideshowConfiguration(.init(
                slideDuration: 5
            ))
            .onboardingSlideshowStyle(.init(
                progressBarBackgroundColor: .green,
                progressBarForegroundColor: .blue
            ))
            .background(
                PreviewBackground(index: pageIndex)
            )
            .safeAreaInset(edge: .bottom) {
                OnboardingPrimaryButton("HEJ") {
                    pageIndex += 1
                }
                .padding([.horizontal, .bottom])
            }
        }

        func handleStoryCompleted() {
            print("Story complete!")
        }
    }
    
    return Preview()
}
