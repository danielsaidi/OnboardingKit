//
//  DelayedOnboardingTests.swift
//  TuttiTests
//
//  Created by Daniel Saidi on 2020-09-06.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Tutti

class DelayedOnboardingTests: QuickSpec {

    override func spec() {

        var onboarding: DelayedOnboarding!

        beforeEach {
            onboarding = DelayedOnboarding(
                id: "onboarding",
                requiredPresentationAttempts: 5)
        }
        
        afterEach {
            onboarding.reset()
            expect(onboarding.presentationCount).to(equal(0))
            expect(onboarding.presentationCheckCount).to(equal(0))
        }
        
        describe("should be presented") {
            
            it("becomes true after a certain number of checks") {
                expect(onboarding.shouldBePresented).to(beFalse())
                expect(onboarding.shouldBePresented).to(beFalse())
                expect(onboarding.shouldBePresented).to(beFalse())
                expect(onboarding.shouldBePresented).to(beFalse())
                expect(onboarding.shouldBePresented).to(beTrue())
            }
            
            it("becomes false when a presentation is registered") {
                expect(onboarding.shouldBePresented).to(beFalse())
                expect(onboarding.shouldBePresented).to(beFalse())
                expect(onboarding.shouldBePresented).to(beFalse())
                expect(onboarding.shouldBePresented).to(beFalse())
                expect(onboarding.shouldBePresented).to(beTrue())
                onboarding.registerPresentation()
                expect(onboarding.shouldBePresented).to(beFalse())
            }
        }
        
        describe("resetting") {
            
            it("resets the presentation counts") {
                _ = onboarding.shouldBePresented
                onboarding.registerPresentation()
                expect(onboarding.presentationCount).to(equal(1))
                expect(onboarding.presentationCheckCount).to(equal(1))
                onboarding.reset()
                expect(onboarding.presentationCount).to(equal(0))
                expect(onboarding.presentationCheckCount).to(equal(0))
            }
        }
    }
}
