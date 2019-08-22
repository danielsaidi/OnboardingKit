//
//  OnboardingPresenter.swift
//  Tutti
//
//  Created by Daniel Saidi on 2018-10-04.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import Foundation

public protocol OnboardingPresenter: AnyObject {}

public extension OnboardingPresenter {
    
    func tryPresent(_ onboarding: Onboarding, presentAction: () -> ()) {
        onboarding.prepareForPresentation()
        guard onboarding.shouldBePresented else { return }
        presentAction()
        onboarding.hasBeenDisplayed = true
    }
}
