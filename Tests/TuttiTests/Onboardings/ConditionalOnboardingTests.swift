//
//  ConditionalOnboardingTests.swift
//  TuttiTests
//
//  Created by Daniel Saidi on 2020-09-09.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Tutti

class ConditionalOnboardingTests: QuickSpec {

    override func spec() {

        var onboarding: ConditionalOnboarding!

        afterEach {
            onboarding.reset()
            expect(onboarding.presentationCount).to(equal(0))
        }
        
        describe("should be presented") {
            
            it("is true if condition it true and hint hasn't been presented") {
                onboarding = ConditionalOnboarding(id: "id", condition: { true })
                expect(onboarding.shouldBePresented).to(beTrue())
            }
            
            it("is false if condition it true, but hint has been presented") {
                onboarding = ConditionalOnboarding(id: "id", condition: { true })
                onboarding.registerPresentation()
                expect(onboarding.shouldBePresented).to(beFalse())
            }
            
            it("is false if condition it false") {
                onboarding = ConditionalOnboarding(id: "id", condition: { false })
                expect(onboarding.shouldBePresented).to(beFalse())
            }
        }
    }
}
