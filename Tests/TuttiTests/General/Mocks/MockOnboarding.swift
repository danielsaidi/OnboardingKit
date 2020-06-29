//
//  MockOnboarding.swift
//  TuttiTests
//
//  Created by Daniel Saidi on 2018-06-18.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import Mockery
import Tutti

class MockOnboarding: Mock, Onboarding {

    init(
        identifier: String,
        userId: String?,
        persistence: OnboardingPersistence) {
        self.identifier = identifier
        self.userId = userId
        self.persistence = persistence
    }

    
    var identifier: String
    var userId: String?
    var persistence: OnboardingPersistence
    
    var shouldBePresented = false
    
    func prepareForPresentation() {}
}
