//
//  OnboardingFlowContainer.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2023-08-25.
//  Copyright © 2023-2026 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This container view can wrap an onboarding flow like the
/// ``OnboardingPageView`` and ``OnboardingSlideshow``.
///
/// The view will add a top-trailing done button, and custom
/// bottom buttons that can control the onboarding.
public struct OnboardingFlowContainer<Page, Content: View, Buttons: View>: View {

    public init(
        pages: [Page],
        pageIndex: Binding<Int>,
        addDoneButton: Bool = true,
        @ViewBuilder content: @escaping () -> Content,
        @ViewBuilder buttons: @escaping (ButtonParams) -> Buttons
    ) {
        self.pages = pages
        self._pageIndex = pageIndex
        self.addDoneButton = addDoneButton
        self.content = content
        self.buttons = buttons
    }

    private let pages: [Page]
    private let addDoneButton: Bool
    private let content: () -> Content
    private let buttons: (ButtonParams) -> Buttons

    @Binding var pageIndex: Int

    public typealias ButtonParams = (
        isFirstPage: Bool,
        isLastPage: Bool,
        previousPage: () -> Void,
        nextPageOrDismiss: () -> Void
    )

    @Environment(\.dismiss)
    private var dismiss

    public var body: some View {
        content()
            .safeAreaInset(edge: .bottom) {
                buttons(buttonParams)
                    .padding([.horizontal, .bottom])
                    .animation(.default, value: pageIndex)
            }
            .toolbar {
                if addDoneButton {
                    Button("Done", action: dismiss.callAsFunction)
                        .labelStyle(.titleOnly)
                }
            }
    }
}

private extension OnboardingFlowContainer {

    var buttonParams: ButtonParams {
        ButtonParams(
            isFirstPage: isCurrentPageFirst,
            isLastPage: isCurrentPageLast,
            previousPage: previousPage,
            nextPageOrDismiss: nextPageOrDismiss
        )
    }

    var currentPage: Page {
        let last = pages[pages.count - 1]
        guard pageIndex < pages.count else { return last }
        return pages[pageIndex]
    }

    var hasPreviousPage: Bool { !isCurrentPageFirst }
    var hasNextPage: Bool { !isCurrentPageLast }
    var isCurrentPageFirst: Bool { pageIndex == 0 }
    var isCurrentPageLast: Bool { pageIndex == (pages.count - 1) }

    func previousPage() {
        guard hasPreviousPage else { return }
        pageIndex -= 1
    }

    func nextPageOrDismiss() {
        guard hasNextPage else { return dismiss() }
        pageIndex += 1
    }
}

#Preview {

    struct Preview: View {

        let pages = Array(0...10)
        @State var pageIndex = 0

        var body: some View {
            if #available(macOS 13.0, *) {
                NavigationView {
                    #if os(macOS)
                    Color.primary
                    #endif
                    OnboardingFlowContainer(
                        pages: pages,
                        pageIndex: $pageIndex,
                        addDoneButton: false,
                        content: {
                            OnboardingPageView(
                                pages: pages,
                                pageIndex: $pageIndex
                            ) { info in
                                OnboardingFlowCenteredContent {
                                    Text("Page \(info.pageIndex)")
                                }
                            }
                        }, buttons: { params in
                            OnboardingPrimaryButton(params.isLastPage ? "Done" : "Next") {
                                withAnimation {
                                    params.nextPageOrDismiss()
                                }
                            }
                        }
                    )
                    .background(Color.red)
                }
            } else {
                Color.red
            }
        }
    }
    
    return Preview()
}
