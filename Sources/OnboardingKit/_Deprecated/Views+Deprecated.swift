import SwiftUI

public extension OnboardingSlideshow {

    @available(*, deprecated, message: "Apply a background to the view instead.")
    init<Background: View> (
        pages: [PageModel],
        pageIndex: Binding<Int>,
        config: OnboardingSlideshowConfiguration = .standard,
        onStoryCompleted: @escaping () -> Void,
        @ViewBuilder background: @escaping (PageInfo) -> Background,
        @ViewBuilder content: @escaping ContentBuilder
    ) {
        self.init(
            pages: pages,
            pageIndex: pageIndex,
            config: config,
            onStoryCompleted: onStoryCompleted,
            content: content
        )
    }
}
