//
//  OnboardingTests.swift
//  OnboardingKitTests
//
//  Created by Daniel Saidi on 2018-06-18.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import Foundation
import OnboardingKit
import XCTest

final class OnboardingTests: XCTestCase {

    var onboarding: Onboarding!

    override func setUp() {
        onboarding = Onboarding(id: "onboarding")
    }

    override func tearDown() {
        onboarding.reset()
        XCTAssertEqual(onboarding.presentationCount, 0)
    }

    func test_persistency_usesStandardUserDefaultsByDefault() {
        let result = onboarding.defaults
        let expected = UserDefaults.standard
        XCTAssertTrue(result === expected)
    }

    func test_hasBeenPresented_isFalseByDefault() {
        XCTAssertFalse(onboarding.hasBeenPresented)
    }

    func test_hasBeenPresented_becomesTrueWhenPresentationIsRegistered() {
        XCTAssertFalse(onboarding.hasBeenPresented)
        onboarding.registerPresentation()
        XCTAssertTrue(onboarding.hasBeenPresented)
    }

    func test_shouldBePresented_isTrueByDefault() {
        XCTAssertTrue(onboarding.shouldBePresented)
    }

    func test_shouldBePresented_becomesFalseWhenPresentationIsRegistered() {
        XCTAssertTrue(onboarding.shouldBePresented)
        onboarding.registerPresentation()
        XCTAssertFalse(onboarding.shouldBePresented)
    }

    func test_persistencyKey_isUniqueForEachUniqueOnbarding() {
        let key = "value"
        let result1 = Onboarding(id: "1").persistencyKey(for: key)
        let result2 = Onboarding(id: "2").persistencyKey(for: key)
        let result3 = Onboarding(id: "1").persistencyKey(for: key)
        XCTAssertEqual(result1, "com.onboardingkit.onboarding.1.value")
        XCTAssertEqual(result2, "com.onboardingkit.onboarding.2.value")
        XCTAssertNotEqual(result1, result2)
        XCTAssertEqual(result1, result3)
    }

    func test_persistencyKey_isUniqueForEachUniqueUser() {
        let key = "value"
        let result1 = Onboarding(id: "1", userId: "user1").persistencyKey(for: key)
        let result2 = Onboarding(id: "1", userId: "user2").persistencyKey(for: key)
        let result3 = Onboarding(id: "1", userId: "user1").persistencyKey(for: key)
        XCTAssertEqual(result1, "com.onboardingkit.onboarding.1.value.user1")
        XCTAssertEqual(result2, "com.onboardingkit.onboarding.1.value.user2")
        XCTAssertNotEqual(result1, result2)
        XCTAssertEqual(result1, result3)
    }

    func test_registeringPresentation_incrementsPresentationCount() {
        XCTAssertEqual(onboarding.presentationCount, 0)
        onboarding.registerPresentation()
        onboarding.registerPresentation()
        onboarding.registerPresentation()
        XCTAssertEqual(onboarding.presentationCount, 3)
    }

    func test_resettingOnboarding_resetsOnboardingPresentationState() {
        onboarding.registerPresentation()
        XCTAssertTrue(onboarding.hasBeenPresented)
        XCTAssertEqual(onboarding.presentationCount, 1)
        onboarding.reset()
        XCTAssertFalse(onboarding.hasBeenPresented)
        XCTAssertEqual(onboarding.presentationCount, 0)
    }
}
