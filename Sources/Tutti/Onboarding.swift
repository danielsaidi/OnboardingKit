//
//  Onboarding.swift
//  Tutti
//
//  Created by Daniel Saidi on 2017-12-06.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This is a base class for various onboarding experiences. It
 can be subclassed to create more specialized behaviors.
 
 The base onboarding behavior is that `shouldBePresented` is
 `true` until `registerPresentation()` is called. After that,
 it's `false` until `reset()` is called. Any specializations
 may change this logic.
 
 If the optional `userId` property is set, this presentation
 logic will be unique for each user.
 
 Note that nothing stops your app from presenting an already
 presented onboarding. Make sure to check `shouldBePresented`
 before presenting it and call `registerPresentation()` when
 you present it.
 */
public class Onboarding {
    
    public init(
        id: String,
        userId: UserId? = nil,
        defaults: UserDefaults = .standard) {
        self.id = id
        self.userId = userId
        self.defaults = defaults
    }
    
    public typealias UserId = String
    
    public let id: String
    public let userId: UserId?
    public let defaults: UserDefaults

    
    /**
     Whether or not the onboarding should be presented. This
     class returns `true` until `registerPresentationAttempt`
     has been called.
     */
    open var shouldBePresented: Bool {
        presentationCount == 0
    }
    
    
    /**
     Call this when you present an onboarding. It increments
     the presentation count, which
     */
    open func registerPresentation() {
        presentationCount += 1
    }
    
    /**
     Call this to reset any previous presentation logic.
     */
    open func reset() {
        presentationCount = 0
    }
}


// MARK: - Public Members

public extension Onboarding {

    /**
     The number of times a presentation has been registered.
     */
    var presentationCount: Int {
        get { defaults.integer(forKey: presentationCountKey) }
        set { defaults.set(newValue, forKey: presentationCountKey) }
    }
    
    /**
     The key to use for persisting values. The key is unique
     for each onboarding and user.
     */
    func persistencyKey(for key: String) -> String {
        let key = "com.tutti.onboarding.\(id).\(key)"
        guard let userId = userId else { return key }
        return "\(key).\(userId)"
    }
}


// MARK: - Internal Mebers

extension Onboarding {
    
    var presentationCountKey: String {
        persistencyKey(for: "presentationCount")
    }
}
