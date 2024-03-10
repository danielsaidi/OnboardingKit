//
//  ConditionalOnboardingTests.swift
//  OnboardingKitTests
//
//  Created by Daniel Saidi on 2020-09-09.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import OnboardingKit
import XCTest

final class ConditionalOnboardingTests: XCTestCase {

    var onboarding: ConditionalOnboarding!
    
    var condition = false
    
    override func setUp() {
        onboarding = .init(
            id: "onboarding",
            condition: { self.condition }
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
            condition: { self.condition }
        )
        XCTAssertEqual(onboarding.id, "test")
        XCTAssertTrue(onboarding.store is TestUserDefaults)
        XCTAssertFalse(onboarding.condition())
        condition = true
        XCTAssertTrue(onboarding.condition())
    }
    
    func testTryPresentOnlyWorksOnceIfConditionIsTrue() {
        var counter = 0
        onboarding.tryPresent { counter += 1 }
        XCTAssertEqual(counter, 0)
        condition = true
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
        onboarding.present {}
        XCTAssertEqual(onboarding.presentationCount, 1)
        onboarding.reset()
        XCTAssertEqual(onboarding.presentationCount, 0)
    }
}
