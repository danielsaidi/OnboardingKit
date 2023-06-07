//
//  CorrectBehaviorOnboardingTests.swift
//  OnboardingKitTests
//
//  Created by Daniel Saidi on 2020-09-06.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

import OnboardingKit
import XCTest

final class CorrectBehaviorOnboardingTests: XCTestCase {

    var onboarding: CorrectBehaviorOnboarding!

    override func setUp() {
        onboarding = CorrectBehaviorOnboarding(
            id: "onboarding",
            requiredIncorrectAttempts: 3)
    }

    override func tearDown() {
        onboarding.reset()
        XCTAssertEqual(onboarding.incorrectBehaviorCount, 0)
        XCTAssertEqual(onboarding.presentationCount, 0)
    }

    func test_shouldBePresented_becomesTrueAfterRequiredNumberOfAttempts() {
        onboarding.registerIncorrectBehavior()
        XCTAssertFalse(onboarding.shouldBePresented)
        onboarding.registerIncorrectBehavior()
        XCTAssertFalse(onboarding.shouldBePresented)
        onboarding.registerIncorrectBehavior()
        XCTAssertTrue(onboarding.shouldBePresented)
    }

    func test_registeringIncorrectBehavior_eventuallyMakesOnboardingPresentable() {
        onboarding.registerIncorrectBehavior()
        onboarding.registerIncorrectBehavior()
        onboarding.registerIncorrectBehavior()
        XCTAssertTrue(onboarding.shouldBePresented)
    }

    func test_registeringCorrectBehavior_resetsOnboardingPresentationState() {
        onboarding.presentationCount = 1
        onboarding.registerIncorrectBehavior()
        XCTAssertEqual(onboarding.incorrectBehaviorCount, 1)
        XCTAssertEqual(onboarding.presentationCount, 1)
        onboarding.registerCorrectBehavior()
        XCTAssertEqual(onboarding.incorrectBehaviorCount, 0)
        XCTAssertEqual(onboarding.presentationCount, 0)
    }

    func test_registeringPresentation_resetsOnboardingPresentationState() {
        onboarding.presentationCount = 1
        onboarding.registerIncorrectBehavior()
        XCTAssertEqual(onboarding.incorrectBehaviorCount, 1)
        XCTAssertEqual(onboarding.presentationCount, 1)
        onboarding.registerPresentation()
        XCTAssertEqual(onboarding.incorrectBehaviorCount, 0)
        XCTAssertEqual(onboarding.presentationCount, 0)
    }

    func test_resettingOnboarding_resetsOnboardingPresentationState() {
        onboarding.presentationCount = 1
        onboarding.registerIncorrectBehavior()
        XCTAssertEqual(onboarding.incorrectBehaviorCount, 1)
        XCTAssertEqual(onboarding.presentationCount, 1)
        onboarding.reset()
        XCTAssertEqual(onboarding.incorrectBehaviorCount, 0)
        XCTAssertEqual(onboarding.presentationCount, 0)
    }
}
