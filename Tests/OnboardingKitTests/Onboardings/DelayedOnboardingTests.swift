//
//  DelayedOnboardingTests.swift
//  OnboardingKitTests
//
//  Created by Daniel Saidi on 2020-09-06.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import OnboardingKit
import XCTest

final class DelayedOnboardingTests: XCTestCase {

    var onboarding: DelayedOnboarding!
    
    override func setUp() {
        onboarding = .init(
            id: "onboarding",
            requiredPresentationAttempts: 3
        )
    }

    override func tearDown() {
        onboarding.reset()
        XCTAssertEqual(onboarding.presentationCount, 0)
    }
    
    
    func testInitializerSetsUpOnboarding() {
        onboarding = .init(
            id: "test",
            store: TestUserDefaults(),
            requiredPresentationAttempts: 1
        )
        XCTAssertEqual(onboarding.id, "test")
        XCTAssertTrue(onboarding.store is TestUserDefaults)
        XCTAssertEqual(onboarding.requiredPresentationAttempts, 1)
    }
    
    func testTryPresentOnlyWorksAfterDelayAndOnlyOnce() {
        var counter = 0
        onboarding.tryPresent { counter += 1 }
        XCTAssertEqual(counter, 0)
        onboarding.tryPresent { counter += 1 }
        XCTAssertEqual(counter, 0)
        onboarding.tryPresent { counter += 1 }
        XCTAssertEqual(counter, 1)
        onboarding.tryPresent { counter += 1 }
        XCTAssertEqual(counter, 1)
    }
    
    func testPresentWorksEveryTime() {
        var counter = 0
        onboarding.present { counter += 1 }
        XCTAssertEqual(counter, 1)
        onboarding.present { counter += 1 }
        XCTAssertEqual(counter, 2)
    }
    
    func testResetResetsOnboardingState() {
        onboarding.tryPresent {}
        onboarding.tryPresent {}
        onboarding.tryPresent {}
        XCTAssertEqual(onboarding.presentationAttempts, 3)
        XCTAssertEqual(onboarding.presentationCount, 1)
        onboarding.reset()
        XCTAssertEqual(onboarding.presentationAttempts, 0)
        XCTAssertEqual(onboarding.presentationCount, 0)
    }
}
