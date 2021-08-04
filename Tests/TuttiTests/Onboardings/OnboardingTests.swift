//
//  OnboardingTests.swift
//  TuttiTests
//
//  Created by Daniel Saidi on 2018-06-18.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Tutti

class OnboardingTests: QuickSpec {

    override func spec() {

        var onboarding: Onboarding!

        beforeEach {
            onboarding = Onboarding(id: "onboarding")
        }
        
        afterEach {
            onboarding.reset()
            expect(onboarding.presentationCount).to(equal(0))
        }
        
        describe("persistency") {
            
            it("uses standard user defaults by default") {
                let result = onboarding.defaults
                expect(result).to(be(UserDefaults.standard))
            }
        }
        
        describe("has been presented") {
            
            it("is false by default") {
                expect(onboarding.hasBeenPresented).to(beFalse())
            }
            
            it("becomes true when a presentation is registered") {
                expect(onboarding.hasBeenPresented).to(beFalse())
                onboarding.registerPresentation()
                expect(onboarding.hasBeenPresented).to(beTrue())
            }
        }
        
        describe("should be presented") {
            
            it("is true by default") {
                expect(onboarding.shouldBePresented).to(beTrue())
            }
            
            it("becomes false when a presentation is registered") {
                expect(onboarding.shouldBePresented).to(beTrue())
                onboarding.registerPresentation()
                expect(onboarding.shouldBePresented).to(beFalse())
            }
        }
        
        describe("persistency key") {
            
            it("is unique for each onboarding") {
                let key = "value"
                let result1 = Onboarding(id: "1").persistencyKey(for: key)
                let result2 = Onboarding(id: "2").persistencyKey(for: key)
                expect(result1).to(equal("com.tutti.onboarding.1.value"))
                expect(result2).to(equal("com.tutti.onboarding.2.value"))
                expect(result1).toNot(equal(result2))
            }
            
            it("is unique for each user") {
                let key = "value"
                let result1 = Onboarding(id: "1", userId: "user1").persistencyKey(for: key)
                let result2 = Onboarding(id: "1", userId: "user2").persistencyKey(for: key)
                expect(result1).to(equal("com.tutti.onboarding.1.value.user1"))
                expect(result2).to(equal("com.tutti.onboarding.1.value.user2"))
                expect(result1).toNot(equal(result2))
            }
        }
        
        describe("registering presentation") {
            
            it("increments the presentation count") {
                expect(onboarding.presentationCount).to(equal(0))
                onboarding.registerPresentation()
                onboarding.registerPresentation()
                onboarding.registerPresentation()
                expect(onboarding.presentationCount).to(equal(3))
            }
        }
        
        describe("resetting") {
            
            it("resets the presentation count") {
                onboarding.registerPresentation()
                expect(onboarding.presentationCount).to(equal(1))
                onboarding.reset()
                expect(onboarding.presentationCount).to(equal(0))
            }
        }
    }
}
