//
//  DeferredOnboardingTests.swift
//  TuttiTests
//
//  Created by Daniel Saidi on 2018-06-18.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
@testable import Tutti

class DeferredOnboardingTests: QuickSpec {
    
    override func spec() {
        
        var persistence: MockOnboardingPersistence!
        
        beforeEach {
            persistence = MockOnboardingPersistence()
        }
        
        func createOnboarding(withUserId userId: String?, requiredAttempts: Int) -> DeferredOnboarding {
            return MockDeferredOnboarding(
                identifier: "foo",
                userId: userId,
                persistence: persistence,
                requiredPresentationAttempts: requiredAttempts)
        }
        
        describe("registered presentation attempts") {
            
            it("returns 0 if no value is set") {
                let onboarding = createOnboarding(withUserId: nil, requiredAttempts: 1)
                expect(onboarding.registeredPresentationAttempts).to(equal(0))
            }
            
            it("returns any set value") {
                let onboarding = createOnboarding(withUserId: nil, requiredAttempts: 1)
                persistence.intValues[onboarding.registeredPresentationAttemptsKey] = 23
                expect(onboarding.registeredPresentationAttempts).to(equal(23))
                persistence.intValues[onboarding.registeredPresentationAttemptsKey] = 13
                expect(onboarding.registeredPresentationAttempts).to(equal(13))
            }
            
            it("affects correct persistens key") {
                let onboarding = createOnboarding(withUserId: nil, requiredAttempts: 1)
                onboarding.registeredPresentationAttempts = 41
                expect(persistence.setIntInvokeCount).to(equal(1))
                expect(persistence.setIntInvokeValues).to(equal([41]))
                expect(persistence.setIntInvokeKeys).to(equal([onboarding.registeredPresentationAttemptsKey]))
            }
        }
        
        describe("registered presentation attempts key") {
            
            it("is valid if no user is specified") {
                let onboarding = createOnboarding(withUserId: nil, requiredAttempts: 1)
                expect(onboarding.registeredPresentationAttemptsKey).to(equal("com.tutti.foo.presentationAttempts"))
            }
            
            it("is valid if a user is specified") {
                let onboarding = createOnboarding(withUserId: "bar", requiredAttempts: 1)
                expect(onboarding.registeredPresentationAttemptsKey).to(equal("com.tutti.foo.presentationAttempts.bar"))
            }
        }
        
        describe("remaining presentation attempts") {
            
            it("returns required attempts if no value is set") {
                let onboarding = createOnboarding(withUserId: nil, requiredAttempts: 10)
                persistence.intValues[onboarding.registeredPresentationAttemptsKey] = 0
                expect(onboarding.remainingPresentationAttempts).to(equal(10))
            }
            
            it("returns correct difference between required and registered attempts") {
                let onboarding = createOnboarding(withUserId: nil, requiredAttempts: 10)
                persistence.intValues[onboarding.registeredPresentationAttemptsKey] = 4
                expect(onboarding.remainingPresentationAttempts).to(equal(6))
            }
            
            it("returns 0 minimum if difference between required and registered attempts is negative") {
                let onboarding = createOnboarding(withUserId: nil, requiredAttempts: 4)
                persistence.intValues[onboarding.registeredPresentationAttemptsKey] = 10
                expect(onboarding.remainingPresentationAttempts).to(equal(0))
            }
        }
        
        describe("registering presentation attempt") {
            
            it("aborts if there are no remaining presentation attempts") {
                let onboarding = createOnboarding(withUserId: nil, requiredAttempts: 10)
                persistence.intValues[onboarding.registeredPresentationAttemptsKey] = 10
                onboarding.registerPresentationAttempt()
                expect(persistence.setIntInvokeCount).to(equal(0))
            }
            
            it("increments persisted value") {
                let onboarding = createOnboarding(withUserId: nil, requiredAttempts: 10)
                persistence.intValues[onboarding.registeredPresentationAttemptsKey] = 3
                onboarding.registerPresentationAttempt()
                expect(persistence.setIntInvokeCount).to(equal(1))
                expect(persistence.setIntInvokeValues).to(equal([4]))
                expect(persistence.setIntInvokeKeys).to(equal([onboarding.registeredPresentationAttemptsKey]))
            }
        }
    }
}
