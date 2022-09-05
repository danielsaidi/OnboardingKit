//
//  DelayedOnboardingTests.swift
//  TuttiTests
//
//  Created by Daniel Saidi on 2020-09-06.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Tutti
import XCTest

final class DelayedOnboardingTests: XCTestCase {

    var onboarding: DelayedOnboarding!

    override func setUp() {
        onboarding = DelayedOnboarding(
            id: "onboarding",
            requiredPresentationAttempts: 5)
    }

    override func tearDown() {
        onboarding.reset()
        XCTAssertEqual(onboarding.presentationCount, 0)
        XCTAssertEqual(onboarding.presentationCheckCount, 0)
    }

    func test_shouldBePresented_becomesTrueAfterRequiredNumberOfChecks() {
        XCTAssertFalse(onboarding.shouldBePresented)
        XCTAssertFalse(onboarding.shouldBePresented)
        XCTAssertFalse(onboarding.shouldBePresented)
        XCTAssertFalse(onboarding.shouldBePresented)
        XCTAssertTrue(onboarding.shouldBePresented)
    }

    func test_shouldBePresented_becomesFalseWhenPresentationIsRegistered() {
        XCTAssertFalse(onboarding.shouldBePresented)
        XCTAssertFalse(onboarding.shouldBePresented)
        XCTAssertFalse(onboarding.shouldBePresented)
        XCTAssertFalse(onboarding.shouldBePresented)
        XCTAssertTrue(onboarding.shouldBePresented)
        onboarding.registerPresentation()
        XCTAssertFalse(onboarding.shouldBePresented)
    }

    func test_resettingOnboarding_resetsOnboardingPresentationState() {
        _ = onboarding.shouldBePresented
        onboarding.registerPresentation()
        XCTAssertEqual(onboarding.presentationCount, 1)
        XCTAssertEqual(onboarding.presentationCheckCount, 1)
        onboarding.reset()
        XCTAssertEqual(onboarding.presentationCount, 0)
        XCTAssertEqual(onboarding.presentationCheckCount, 0)
    }
}
