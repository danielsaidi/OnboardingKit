//
//  ConditionalOnboardingTests.swift
//  OnboardingKitTests
//
//  Created by Daniel Saidi on 2020-09-09.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

import OnboardingKit
import XCTest

final class ConditionalOnboardingTests: XCTestCase {

    var onboarding: Onboarding!

    override func tearDown() {
        onboarding.reset()
        XCTAssertEqual(onboarding.presentationCount, 0)
    }

    func test_shouldBePresented_isTrueIfConditionIsTrueAndOnboardingHasNotBeenPresented() {
        onboarding = ConditionalOnboarding(id: "id", condition: { true })
        XCTAssertTrue(onboarding.shouldBePresented)
    }

    func test_shouldBePresented_isFalseIfConditionIsTrueButOnboardingHasBeenPresented() {
        onboarding = ConditionalOnboarding(id: "id", condition: { true })
        onboarding.registerPresentation()
        XCTAssertFalse(onboarding.shouldBePresented)
    }

    func test_shouldBePresented_isFalseIfConditionIsFalse() {
        onboarding = ConditionalOnboarding(id: "id", condition: { false })
        XCTAssertFalse(onboarding.shouldBePresented)
    }
}
