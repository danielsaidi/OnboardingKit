//
//  View+Popover.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2025-05-23.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

@available(iOS 16.4, *)
public extension View {

    /// Present a text popover from the view.
    func onboardingPopover(
        _ text: String,
        isPresented: Binding<Bool>
    ) -> some View {
        self.onboardingPopover(isPresented: isPresented) {
            Text(text)
                #if os(iOS)
                .fixedSize(horizontal: false, vertical: true)
                #endif
                .padding()
                .padding(.vertical)
        }
    }

    /// Present a content view popover from the view.
    func onboardingPopover<Content: View>(
        isPresented: Binding<Bool>,
        content: @escaping () -> Content
    ) -> some View {
        self.popover(isPresented: isPresented) {
            content()
                #if os(iOS)
                .presentationCompactAdaptation(.popover)
                #endif
        }
    }
}
