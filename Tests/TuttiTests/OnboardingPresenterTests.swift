//
//  OnboardingPresenterTests.swift
//  TuttiTests
//
//  Created by Daniel Saidi on 2020-09-06.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Tutti

class OnboardingPresenterTests: QuickSpec {

    override func spec() {

        var onboarding: Onboarding!
        var presenter: OnboardingPresenter!

        beforeEach {
            onboarding = Onboarding(id: "onboarding")
            presenter = MockPresenter()
        }
        
        afterEach {
            onboarding.reset()
            expect(onboarding.presentationCount).to(equal(0))
        }
        
        describe("trying to present onboarding") {
            
            it("aborts if the onboarding should not be presented") {
                onboarding.registerPresentation()
                expect(onboarding.shouldBePresented).to(beFalse())
                var counter = 0
                presenter.tryPresent(onboarding) { counter += 1 }
                expect(counter).toEventually(equal(0))
            }
            
            it("calls the present action if the onboarding should be presented") {
                expect(onboarding.shouldBePresented).to(beTrue())
                var counter = 0
                presenter.tryPresent(onboarding) { counter += 1 }
                expect(counter).toEventually(equal(1))
            }
            
            it("registers the presentation for the provided onboarding") {
                expect(onboarding.shouldBePresented).to(beTrue())
                presenter.tryPresent(onboarding) {}
                expect(onboarding.shouldBePresented).toEventually(beFalse())
            }
        }
    }
}

private class MockPresenter: OnboardingPresenter {}
