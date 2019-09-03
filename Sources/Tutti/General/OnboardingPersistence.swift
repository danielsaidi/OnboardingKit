//
//  OnboardingPersistence.swift
//  Tutti
//
//  Created by Daniel Saidi on 2018-06-18.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by any class that can be
 used to persist values raw values.
 */
public protocol OnboardingPersistence {

    func set(_ value: Int, forKey: String)
    func set(_ value: Bool, forKey: String)
    func bool(forKey: String) -> Bool
    func integer(forKey: String) -> Int
}

extension OnboardingPersistence {
    
    func key(for onboarding: Onboarding, objectKey: String, userId: String?) -> String {
        let key = "com.tutti.\(onboarding.identifier).\(objectKey)"
        guard let userId = userId else { return key }
        return "\(key).\(userId)"
    }
}

extension UserDefaults: OnboardingPersistence {}
