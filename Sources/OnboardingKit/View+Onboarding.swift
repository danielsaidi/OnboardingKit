//
//  View+Onboarding.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2024-04-22.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension View {

    /// Present an onboarding, with an optional delay.
    ///
    /// This is a shorthand for the onboarding presentation, which will result in a
    /// cleaner call site:
    ///
    /// ```swift
    /// struct MyView: View {
    ///
    ///     var body: some View { ... }
    ///
    ///     func presentOnboarding() {
    ///         tryPresent(.welcome) { ... }
    ///     }
    /// ```
    func tryPresentOnboarding(
        _ onboarding: Onboarding,
        after delay: TimeInterval = 1,
        presentation: @escaping () -> Void
    ) {
        onboarding.tryPresent(
            after: delay,
            action: presentation
        )
    }
}
