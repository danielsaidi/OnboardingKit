//
//  OnboardingPresenter.swift
//  Tutti
//
//  Created by Daniel Saidi on 2018-10-04.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import Foundation

@available(*, deprecated, message: "Use the new Onboarding.tryPresent function instead")
public protocol OnboardingPresenter {}

@available(*, deprecated, message: "Use the new Onboarding.tryPresent function instead")
public extension OnboardingPresenter {

    func tryPresent(_ onboarding: Onboarding, presentAction: () -> Void) {
        guard onboarding.shouldBePresented else { return }
        presentAction()
        onboarding.registerPresentation()
    }
}
