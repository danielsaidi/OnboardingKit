//
//  OnboardingSlideshow.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2022-09-04.
//  Copyright © 2022-2024 Kankoda. All rights reserved.
//

#if os(iOS)
import Combine
import SwiftUI

/// This slideshow slides through a set of slide views.
///
/// Since this view adds full content buttons to navigate to
/// the previous and next slide, you must specify background
/// content separately from the page content. Any background
/// added to the content will block out these touches.
///
/// Apply a ``SwiftUI/View/onboardingSlideshowStyle(_:)`` to 
/// customize the visual style of a slideshow.
public struct OnboardingSlideshow<Page, Background: View, Content: View>: View {

    /// Create a story slideshow.
    ///
    /// - Parameters:
    ///   - pages: The pages to present.
    ///   - pageIndex: The current page index.
    ///   - onStoryCompleted: The action to trigger at the end.
    ///   - background: A page content builder function.
    ///   - content: A page content builder function.
    public init(
        pages: [Page],
        pageIndex: Binding<Int>,
        config: OnboardingSlideshowConfiguration = .standard,
        onStoryCompleted: @escaping () -> Void,
        @ViewBuilder background: @escaping BackgroundBuilder,
        @ViewBuilder content: @escaping ContentBuilder
    ) {
        self.pages = pages
        self._pageIndex = pageIndex
        self.config = config
        self.onStoryCompleted = onStoryCompleted
        self.background = background
        self.content = content
        self.timer = Timer.publish(
            every: config.slideDuration * config.timerTickIncrement,
            on: .main,
            in: .common
        )
        .autoconnect()
    }

    public typealias PageInfo = OnboardingPageInfo<Page>
    public typealias BackgroundBuilder = (PageInfo) -> Background
    public typealias ContentBuilder = (PageInfo) -> Content

    private let pages: [Page]
    private let config: OnboardingSlideshowConfiguration
    private let timer: Publishers.Autoconnect<Timer.TimerPublisher>
    private let onStoryCompleted: () -> Void
    private let background: BackgroundBuilder
    private let content: ContentBuilder

    @Binding
    private var pageIndex: Int

    @Environment(\.onboardingSlideshowStyle)
    private var style
    
    @State
    private var currentProgress = 0.0

    @State
    private var isTimerRunning = true
    
    public var body: some View {
        ZStack {
            backgroundView
            VStack {
                progressViews
                slideViews
            }
        }
        .onReceive(timer) { _ in
            guard isTimerRunning else { return }
            handleTimerTick()
        }
    }
}

// MARK: - Views

private extension OnboardingSlideshow {

    var backgroundView: some View {
        background(
            .init(
                page: pages[pageIndex],
                pageIndex: pageIndex,
                currentPageIndex: pageIndex,
                totalPageCount: pages.count
            )
        )
        .ignoresSafeArea()
    }

    var progressViews: some View {
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

    var slideViews: some View {
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
    }

    func content(
        for info: EnumeratedSequence<[Page]>.Element
    ) -> some View {
        content(
            .init(
                page: info.element,
                pageIndex: info.offset,
                currentPageIndex: pageIndex,
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
        Color.clear
            .contentShape(Rectangle())
            .accessibilityLabel(Text(
                next ? config.nextAccessibilityLabel : config.previousAccessibilityLabel))
            .onTapGesture {
                next ? nextSlide() : previousSlide()
            }
            .onLongPressGesture(
                minimumDuration: 60,
                maximumDistance: 100,
                perform: {},
                onPressingChanged: {
                    isTimerRunning = !$0
                }
            )
    }
}

// MARK: - Slide Controls

private extension OnboardingSlideshow {
    
    var isFullProgress: Bool {
        currentProgress >= 1
    }
    
    func endSlides() {
        currentProgress = 1
        isTimerRunning = false
        onStoryCompleted()
    }
    
    func handleTimerTick() {
        if isFullProgress { return nextSlide() }
        withAnimation {
            let newProgress = currentProgress + config.timerTickIncrement
            currentProgress = min(newProgress, 1)
        }
    }
    
    func nextSlide() {
        let index = pages.index(after: pageIndex)
        guard index < pages.endIndex else { return endSlides() }
        setNewIndex(index)
    }
    
    func previousSlide() {
        let index = pages.index(before: pageIndex)
        guard index >= pages.startIndex else { return }
        setNewIndex(index)
    }
    
    func setNewIndex(_ index: Int) {
        if config.isAnimated {
            withAnimation {
                setNewIndexPlain(index)
            }
        } else {
            setNewIndexPlain(index)
        }
    }
    
    func setNewIndexPlain(_ index: Int) {
        pageIndex = index
        currentProgress = 0.0
        isTimerRunning = true
    }
}


// MARK: - Preview

#Preview {

    struct Preview: View {

        @State
        private var index = 0

        var body: some View {
            OnboardingSlideshow(
                pages: Array(0...2),
                pageIndex: $index,
                onStoryCompleted: handleStoryCompleted,
                background: background,
                content: content
            )
        }

        func background(
            for info: OnboardingPageInfo<Int>
        ) -> some View {
            PreviewBackground(index: info.pageIndex)
        }

        func content(
            for info: OnboardingPageInfo<Int>
        ) -> some View {
            PreviewPage(index: $index, info: info)
        }

        func handleStoryCompleted() {
            print("Story complete!")
        }
    }
    
    return Preview()
}
#endif
