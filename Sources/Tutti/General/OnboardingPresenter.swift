//
//  OnboardingPresenter.swift
//  Tutti
//
//  Created by Daniel Saidi on 2018-10-04.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol is implemented by every built-in tutorial and
 hint presenter.
 */
public protocol OnboardingPresenter: AnyObject {}

public extension OnboardingPresenter {

    /**
     Try presenting a certain onboarding experience. It will
     fail if the onboarding should not be performed, e.g. if
     it has already been presented.
     */
    func tryPresent(_ onboarding: Onboarding, presentAction: () -> ()) {
        onboarding.prepareForPresentation()
        guard onboarding.shouldBePresented else { return }
        presentAction()
        onboarding.hasBeenDisplayed = true
    }
}
