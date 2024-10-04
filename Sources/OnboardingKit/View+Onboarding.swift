//
//  View+Onboarding.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2024-04-22.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension View {

    /// Present an onboarding, with an optional delay.
    ///
    /// This is a convenience shorthand for the onboarding's
    /// ``Onboarding/tryPresent(after:action:)``, which will
    /// result in cleaner code when calling it with a static
    /// onboarding value, for instance:
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
