//
//  CorrectBehaviorTutorial.swift
//  Tutti
//
//  Created by Daniel Saidi on 2018-10-09.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

/*
 
 This is a user behavior-based tutorial that is presented if
 the user performs a certain number of incorrect "behaviors".
 Since it is in charge of triggering a presentation, it must
 be provided a presenter, which it will call when needed.
 
 */

import UIKit

open class CorrectBehaviorTutorial: StandardTutorial, CorrectBehaviorOnboarding {
    
    
    // MARK: - Initialization
    
    public init(
        identifier: String,
        pageCount: Int,
        requiredIncorrectBehaviors: Int,
        presenter: TutorialPresenter,
        userId: String? = nil,
        keySegmentSeparator: String = "_",
        persistence: OnboardingPersistence = UserDefaults.standard) {
        self.requiredIncorrectBehaviors = requiredIncorrectBehaviors
        self.presenter = presenter
        super.init(
            identifier: identifier,
            pageCount: pageCount,
            userId: userId,
            keySegmentSeparator: keySegmentSeparator,
            persistence: persistence)
    }
    
    public init(
        fromLocalizationWithPageIndicationKey key: String,
        identifier: String,
        requiredIncorrectBehaviors: Int,
        presenter: TutorialPresenter,
        userId: String? = nil,
        keySegmentSeparator: String = "_",
        persistence: OnboardingPersistence = UserDefaults.standard) {
        self.requiredIncorrectBehaviors = requiredIncorrectBehaviors
        self.presenter = presenter
        super.init(
            fromLocalizationWithPageIndicationKey: key,
            identifier: identifier,
            userId: userId,
            keySegmentSeparator: keySegmentSeparator,
            persistence: persistence)
    }
    
    
    // MARK: - Properties
    
    public var registeredIncorrectBehaviors: Int = 0
    
    public let requiredIncorrectBehaviors: Int
    
    public weak var presenter: TutorialPresenter?
    
    open override var shouldBePresented: Bool {
        return remainingAttempts == 0
    }
    
    
    // MARK: - Functions
    
    public func triggerPresentation(in vc: UIViewController, from view: UIView) {
        presenter?.present(self, in: vc, from: view)
    }
}
