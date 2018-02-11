//
//  OnboardingTests.swift
//  TuttiTests
//
//  Created by Daniel Saidi on 2017-12-06.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import Tutti

class OnboardingTests: QuickSpec {
    
    override func spec() {
        
        var onboarding: Onboarding!
        
        func getOnboarding(id: String, userId: String?) -> Onboarding {
            return StandardTutorial(identifier: id, pageCount: 0, userId: userId)
        }
        
        func set(key: String, toDisplayState bool: Bool) {
            let defaults = UserDefaults.standard
            defaults.set(bool, forKey: key)
            defaults.synchronize()
        }
        
        
        context("user-unspecific onboarding") {
        
            let key = "com.Tutti.foo"
            
            beforeEach {
                onboarding = getOnboarding(id: "foo", userId: nil)
            }
            
            afterEach {
                set(key: key, toDisplayState: false)
            }
            
            describe("displayed state") {
                
                it("is false by default") {
                    expect(onboarding.hasBeenDisplayed).to(beFalse())
                }
                
                it("is false if user defaults has no matching key") {
                    onboarding.hasBeenDisplayed = true
                    set(key: key, toDisplayState: false)
                    expect(onboarding.hasBeenDisplayed).to(beFalse())
                }
                
                it("is true if user defaults has matching key") {
                    set(key: key, toDisplayState: true)
                    expect(onboarding.hasBeenDisplayed).to(beTrue())
                }
                
                it("is shared with another user-unspecific instance") {
                    onboarding.hasBeenDisplayed = true
                    let anotherOnboarding = getOnboarding(id: "foo", userId: nil)
                    expect(anotherOnboarding.hasBeenDisplayed).to(beTrue())
                }
                
                it("is not shared with a user-specific instance") {
                    onboarding.hasBeenDisplayed = true
                    let anotherOnboarding = getOnboarding(id: "foo", userId: "bar")
                    expect(anotherOnboarding.hasBeenDisplayed).to(beFalse())
                }
            }
        }
        
        
        context("user-specific onboarding") {
            
            let key = "com.Tutti.foo.bar"
            
            beforeEach {
                onboarding = getOnboarding(id: "foo", userId: "bar")
            }
            
            afterEach {
                set(key: key, toDisplayState: false)
            }
            
            describe("displayed state") {
                
                it("is false by default") {
                    expect(onboarding.hasBeenDisplayed).to(beFalse())
                }
                
                it("is false if user defaults has no matching key") {
                    onboarding.hasBeenDisplayed = true
                    set(key: key, toDisplayState: false)
                    expect(onboarding.hasBeenDisplayed).to(beFalse())
                }
                
                it("is true if user defaults has matching key") {
                    set(key: key, toDisplayState: true)
                    expect(onboarding.hasBeenDisplayed).to(beTrue())
                }
                
                it("is not shared with a user-unspecific instance") {
                    onboarding.hasBeenDisplayed = true
                    let anotherOnboarding = getOnboarding(id: "foo", userId: nil)
                    expect(anotherOnboarding.hasBeenDisplayed).to(beFalse())
                }
                
                it("is shared with another same user-specific instance") {
                    onboarding.hasBeenDisplayed = true
                    let anotherOnboarding = getOnboarding(id: "foo", userId: "bar")
                    expect(anotherOnboarding.hasBeenDisplayed).to(beTrue())
                }
                
                it("is not shared with another different user-specific instance") {
                    onboarding.hasBeenDisplayed = true
                    let anotherOnboarding = getOnboarding(id: "foo", userId: "baz")
                    expect(anotherOnboarding.hasBeenDisplayed).to(beFalse())
                }
            }
        }
    }
}
