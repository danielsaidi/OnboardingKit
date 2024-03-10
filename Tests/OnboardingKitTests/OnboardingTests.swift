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
        onboarding = .init(id: "onboarding")
    }

    override func tearDown() {
        onboarding.reset()
        XCTAssertEqual(onboarding.presentationCount, 0)
    }
    
    
    func testInitializerSetsUpOnboarding() {
        onboarding = .init(
            id: "test",
            store: TestUserDefaults()
        )
        XCTAssertEqual(onboarding.id, "test")
        XCTAssertTrue(onboarding.store is TestUserDefaults)
    }
    
    func testTryPresentOnlyWorksOnce() {
        var counter = 0
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
