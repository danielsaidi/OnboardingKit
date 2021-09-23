//
//  OnboardingPresenter.swift
//  Tutti
//
//  Created by Daniel Saidi on 2018-10-04.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by types that are meant to
 present onboarding experiences.
 
 The protocol doesn't require any properties or functions to
 be implemented. It only provides standardized functionality
 for working with onboarding experiences.
 */
public protocol OnboardingPresenter: AnyObject {}

public extension OnboardingPresenter {

    /**
     Try presenting a certain onboarding experience.
     
     This operation will be aborted if the onboarding should
     not be presented, otherwise the provided `presentAction`
     block will be called.
     */
    func tryPresent(_ onboarding: Onboarding, presentAction: () -> Void) {
        guard onboarding.shouldBePresented else { return }
        presentAction()
        onboarding.registerPresentation()
    }
}
