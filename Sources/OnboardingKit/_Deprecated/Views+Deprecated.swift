import SwiftUI

public extension OnboardingSlideshow {

    @available(*, deprecated, message: "Apply a background and configuration to the view instead.")
    init<Background: View> (
        pages: [PageModel],
        pageIndex: Binding<Int>,
        config: OnboardingSlideshowConfiguration = .standard,
        onStoryCompleted: @escaping () -> Void,
        @ViewBuilder background: @escaping (PageInfo) -> Background,
        @ViewBuilder content: @escaping PageBuilder
    ) {
        self.init(
            pages: pages,
            pageIndex: pageIndex,
            onStoryCompleted: onStoryCompleted,
            content: content
        )
    }
}

public extension OnboardingSlideshowConfiguration {

    @available(*, deprecated, message: "isAnimated is no longer supported.")
    init(
        isAnimated: Bool?,
        slideDuration: TimeInterval? = nil,
        timeTickIncrement: TimeInterval? = nil,
        nextAccessibilityLabel: String? = nil,
        previousAccessibilityLabel: String? = nil
    ) {
        self.init(
            slideDuration: slideDuration,
            timeTickIncrement: timeTickIncrement,
            nextAccessibilityLabel: nextAccessibilityLabel,
            previousAccessibilityLabel: previousAccessibilityLabel
        )
    }
}
