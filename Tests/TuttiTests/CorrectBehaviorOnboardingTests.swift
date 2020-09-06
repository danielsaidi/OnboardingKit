//
//  CorrectBehaviorOnboardingTests.swift
//  TuttiTests
//
//  Created by Daniel Saidi on 2020-09-06.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Mockery
import Tutti

class CorrectBehaviorOnboardingTests: QuickSpec {

    override func spec() {

        var onboarding: CorrectBehaviorOnboarding!

        beforeEach {
            onboarding = CorrectBehaviorOnboarding(
                id: "onboarding",
                requiredIncorrectAttempts: 3)
        }
        
        afterEach {
            onboarding.reset()
            expect(onboarding.incorrectBehaviorCount).to(equal(0))
            expect(onboarding.presentationCount).to(equal(0))
        }
        
        describe("should be presented") {
            
            it("becomes true after a certain number of checks") {
                onboarding.registerIncorrectBehavior()
                expect(onboarding.shouldBePresented).to(beFalse())
                onboarding.registerIncorrectBehavior()
                expect(onboarding.shouldBePresented).to(beFalse())
                onboarding.registerIncorrectBehavior()
                expect(onboarding.shouldBePresented).to(beTrue())
            }
        }
        
        describe("registering incorrect behavior") {
            
            it("increments the counter until hint should be presented") {
                onboarding.registerIncorrectBehavior()
                onboarding.registerIncorrectBehavior()
                onboarding.registerIncorrectBehavior()
                expect(onboarding.shouldBePresented).to(beTrue())
            }
        }
        
        describe("registering correct behavior") {
            
            it("resets the onboarding") {
                onboarding.presentationCount = 1
                onboarding.registerIncorrectBehavior()
                expect(onboarding.incorrectBehaviorCount).to(equal(1))
                expect(onboarding.presentationCount).to(equal(1))
                onboarding.registerCorrectBehavior()
                expect(onboarding.incorrectBehaviorCount).to(equal(0))
                expect(onboarding.presentationCount).to(equal(0))
            }
        }
        
        describe("registering presentation") {
            
            it("resets the onboarding") {
                onboarding.presentationCount = 1
                onboarding.registerIncorrectBehavior()
                expect(onboarding.incorrectBehaviorCount).to(equal(1))
                expect(onboarding.presentationCount).to(equal(1))
                onboarding.registerPresentation()
                expect(onboarding.incorrectBehaviorCount).to(equal(0))
                expect(onboarding.presentationCount).to(equal(0))
            }
        }
        
        describe("resetting") {
            
            it("resets the presentation counts") {
                onboarding.presentationCount = 1
                onboarding.registerIncorrectBehavior()
                expect(onboarding.incorrectBehaviorCount).to(equal(1))
                expect(onboarding.presentationCount).to(equal(1))
                onboarding.reset()
                expect(onboarding.incorrectBehaviorCount).to(equal(0))
                expect(onboarding.presentationCount).to(equal(0))
            }
        }
    }
}
