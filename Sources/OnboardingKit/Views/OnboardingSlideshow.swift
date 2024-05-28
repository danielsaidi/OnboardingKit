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
/// Apply a ``SwiftUI/View/onboardingSlideshowStyle(_:)`` to 
/// customize the visual style of a slideshow.
public struct OnboardingSlideshow<Page, BackgroundView: View, ButtonView: View, PageView: View>: View {

    /// Create a story slideshow.
    ///
    /// - Parameters:
    ///   - pages: The pages to present.
    ///   - onStoryCompleted: The action to trigger once the story completes.
    ///   - background: A background builder function.
    ///   - pageView: A page builder function.
    ///   - button: A bottom button builder function.
    public init(
        pages: [Page],
        config: OnboardingSlideshowConfiguration = .standard,
        onStoryCompleted: @escaping () -> Void,
        background: @escaping BackgroundBuilder,
        pageView: @escaping PageViewBuilder,
        button: @escaping ButtonBuilder
    ) {
        self.pages = pages
        self.config = config
        self.onStoryCompleted = onStoryCompleted
        self.backgroundBuilder = background
        self.buttonBuilder = button
        self.pageView = pageView
        self.timer = Timer.publish(
            every: config.slideDuration * config.timerTickIncrement,
            on: .main,
            in: .common
        ).autoconnect()
    }
    
    private let pages: [Page]
    private let config: OnboardingSlideshowConfiguration
    private let timer: Publishers.Autoconnect<Timer.TimerPublisher>
    private let onStoryCompleted: () -> Void
    private let backgroundBuilder: BackgroundBuilder
    private let buttonBuilder: ButtonBuilder
    private let pageView: PageViewBuilder

    @Environment(\.onboardingSlideshowStyle)
    private var style

    @State
    private var currentIndex = 0
    
    @State
    private var currentProgress = 0.0

    @State
    private var isTimerRunning = true
    
    public var body: some View {
        VStack {   // Needed for the nested timer to trigger
            VStack {
                progressViews
                slideViews
                button
            }
            .onReceive(timer) { _ in
                guard isTimerRunning else { return }
                handleTimerTick()
            }
        }
        .background(backgroundColor)
    }
}

// MARK: - Typealiases

public extension OnboardingSlideshow {
    
    /// A function used to generate a slide background view.
    typealias BackgroundBuilder = (Page) -> BackgroundView

    /// A function used to generate a slide primary button.
    typealias ButtonBuilder = (Page) -> ButtonView

    /// A function used to generate a slide view.
    typealias PageViewBuilder = (Page) -> PageView
}

// MARK: - Properties

private extension OnboardingSlideshow {

    var currentPage: Page {
        pages[currentIndex]
    }
}

// MARK: - Views

private extension OnboardingSlideshow {

    var backgroundColor: some View {
        backgroundBuilder(currentPage)
            .ignoresSafeArea()
    }
    
    var button: some View {
        buttonBuilder(currentPage)
            .padding()
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
        TabView(selection: $currentIndex) {
            ForEach(0..<pages.count, id: \.self) {
                pageView(pages[$0])
                    .padding()
                    .tag($0)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .overlay(
            HStack(spacing: 0) {
                overlayControl(next: false)
                overlayControl(next: true)
            }
        )
    }
    
    func progressView(_ slideIndex: Int) -> some View {
        OnboardingSlideshowProgressView(
            index: slideIndex,
            slideshowIndex: currentIndex,
            slideshowProgress: currentProgress
        )
        .padding(.vertical)
        .contentShape(Rectangle())
    }
    
    func overlayControl(next: Bool) -> some View {
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
        let index = pages.index(after: currentIndex)
        guard index < pages.endIndex else { return endSlides() }
        setNewIndex(index)
    }
    
    func previousSlide() {
        let index = pages.index(before: currentIndex)
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
        currentIndex = index
        currentProgress = 0.0
        isTimerRunning = true
    }
}


// MARK: - Preview

#Preview {

    struct Preview: View {
        
        var pages: [Color] = [.red, .green, .blue, .purple]
        
        @State
        private var buttonTapCount = 0

        var body: some View {
            OnboardingSlideshow(
                pages: Array(0...2),
                onStoryCompleted: handleStoryCompleted,
                background: background,
                pageView: pageView,
                button: button
            )
        }

        func background(for page: Int) -> Color {
            switch page {
            case 0: .red
            case 1: .green
            case 2: .blue
            default: .gray
            }
        }

        func button(for page: Int) -> some View {
            Button(page == 2 ? "Done" : "Button", action: handleButtonTap)
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
        }

        func pageView(for page: Int) -> some View {
            Text("Page \(page+1)")
        }

        func handleButtonTap() {
            print("Button tapped!")
        }
        
        func handleStoryCompleted() {
            print("Story complete!")
        }
    }
    
    return Preview()
}
#endif
