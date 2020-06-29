//
//  OnboardingTests.swift
//  TuttiTests
//
//  Created by Daniel Saidi on 2018-06-18.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
@testable import Tutti

class OnboardingTests: QuickSpec {
    
    override func spec() {
        
        var persistence: MockOnboardingPersistence!
        
        beforeEach {
            persistence = MockOnboardingPersistence()
        }
        
        func createOnboarding(withUserId userId: String?) -> Onboarding {
            MockOnboarding(identifier: "foo", userId: userId, persistence: persistence)
        }
        
        describe("has been displayed key") {
            
            it("is valid if no user is specified") {
                let onboarding = createOnboarding(withUserId: nil)
                expect(onboarding.hasBeenDisplayedKey).to(equal("com.tutti.foo.hasBeenDisplayed"))
            }
            
            it("is valid if a user is specified") {
                let onboarding = createOnboarding(withUserId: "bar")
                expect(onboarding.hasBeenDisplayedKey).to(equal("com.tutti.foo.hasBeenDisplayed.bar"))
            }
        }
        
        describe("has been displayed") {
            
            context("for user-unspecific onboarding") {
                
                it("returns false if no value is set") {
                    let onboarding = createOnboarding(withUserId: nil)
                    expect(onboarding.hasBeenDisplayed).to(beFalse())
                }
                
                it("returns any set value") {
                    let onboarding = createOnboarding(withUserId: nil)
                    persistence.boolValues["com.tutti.foo.hasBeenDisplayed"] = true
                    expect(onboarding.hasBeenDisplayed).to(beTrue())
                    persistence.boolValues["com.tutti.foo.hasBeenDisplayed"] = false
                    expect(onboarding.hasBeenDisplayed).to(beFalse())
                }
                
                it("affects correct persistens key") {
                    let onboarding = createOnboarding(withUserId: nil)
                    onboarding.hasBeenDisplayed = true
                    expect(persistence.setBoolInvokeCount).to(equal(1))
                    expect(persistence.setBoolInvokeValues).to(equal([true]))
                    expect(persistence.setBoolInvokeKeys).to(equal(["com.tutti.foo.hasBeenDisplayed"]))
                }
            }
            
            context("for user-specific onboarding") {
                
                it("returns false if no value is set") {
                    let onboarding = createOnboarding(withUserId: "bar")
                    expect(onboarding.hasBeenDisplayed).to(beFalse())
                }
                
                it("returns any set value") {
                    let onboarding = createOnboarding(withUserId: "bar")
                    persistence.boolValues["com.tutti.foo.hasBeenDisplayed.bar"] = true
                    expect(onboarding.hasBeenDisplayed).to(beTrue())
                    persistence.boolValues["com.tutti.foo.hasBeenDisplayed.bar"] = false
                    expect(onboarding.hasBeenDisplayed).to(beFalse())
                }
                
                it("affects correct persistens key") {
                    let onboarding = createOnboarding(withUserId: "bar")
                    onboarding.hasBeenDisplayed = true
                    expect(persistence.setBoolInvokeCount).to(equal(1))
                    expect(persistence.setBoolInvokeValues).to(equal([true]))
                    expect(persistence.setBoolInvokeKeys).to(equal(["com.tutti.foo.hasBeenDisplayed.bar"]))
                }
            }
        }
    }
}
