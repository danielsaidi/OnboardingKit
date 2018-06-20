//
//  StandardDeferredTutorialTests.swift
//  TuttiTests
//
//  Created by Daniel Saidi on 2018-06-19.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
@testable import Tutti

class StandardDeferredTutorialTests: QuickSpec {
    
    override func spec() {
        
        var persistence: MockOnboardingPersistence!
        var presenter: MockTutorialPresenter!
        
        beforeEach {
            persistence = MockOnboardingPersistence()
            presenter = MockTutorialPresenter()
        }
        
        func createTutorial(requiredPresentationAttempts: Int) -> StandardDeferredTutorial {
            return StandardDeferredTutorial(
                identifier: "foo",
                pageCount: 3,
                requiredPresentationAttempts: requiredPresentationAttempts,
                userId: "bar",
                keySegmentSeparator: "baz",
                persistence: persistence)
        }
        
        
        describe("when created") {
            
            it("sets all properties") {
                let tutorial = createTutorial(requiredPresentationAttempts: 3)
                expect(tutorial.identifier).to(equal("foo"))
                expect(tutorial.pageCount).to(equal(3))
                expect(tutorial.requiredPresentationAttempts).to(equal(3))
                expect(tutorial.userId).to(equal("bar"))
                expect(tutorial.keySegmentSeparator).to(equal("baz"))
                expect(tutorial.persistence).to(be(persistence))
            }
            
            it("uses user default persistence by default") {
                let tutorial = StandardDeferredTutorial(identifier: "", pageCount: 1, requiredPresentationAttempts: 121)
                expect(tutorial.persistence).to(be(UserDefaults.standard))
            }
        }
        
        
        describe("should be presented") {
            
            it("should be presented if it hasn't been displayed and the remaining presentation attempts is 0") {
                let tutorial = createTutorial(requiredPresentationAttempts: 10)
                persistence.intValues[tutorial.registeredPresentationAttemptsKey] = 10
                expect(tutorial.shouldBePresented).to(beTrue())
            }
            
            it("should not be presented if it has been displayed") {
                let tutorial = createTutorial(requiredPresentationAttempts: 10)
                persistence.boolValues[tutorial.hasBeenDisplayedKey] = true
                persistence.intValues[tutorial.registeredPresentationAttemptsKey] = 10
                expect(tutorial.shouldBePresented).to(beFalse())
            }
            
            it("should not be presented if it has remaining presentation attempts") {
                let tutorial = createTutorial(requiredPresentationAttempts: 10)
                persistence.intValues[tutorial.registeredPresentationAttemptsKey] = 3
                expect(tutorial.shouldBePresented).to(beFalse())
            }
        }
        
        
        describe("when presenting") {
            
            it("registers presentation attempt") {
                let tutorial = createTutorial(requiredPresentationAttempts: 10)
                persistence.intValues[tutorial.registeredPresentationAttemptsKey] = 2
                tutorial.present(with: presenter, in: UIViewController(), from: UIView())
                expect(persistence.setIntInvokeCount).to(equal(1))
                expect(persistence.setIntInvokeValues).to(equal([3]))
                expect(persistence.setIntInvokeKeys).to(equal([tutorial.registeredPresentationAttemptsKey]))
            }
            
            it("aborts if it shouldn't be presented") {
                let tutorial = createTutorial(requiredPresentationAttempts: 10)
                tutorial.present(with: presenter, in: UIViewController(), from: UIView())
                expect(presenter.presentInvokeCount).to(equal(0))
            }
            
            it("asks presenter to present it from valid context") {
                let tutorial = createTutorial(requiredPresentationAttempts: 10)
                persistence.intValues[tutorial.registeredPresentationAttemptsKey] = 10
                let vc = UIViewController()
                let view = UIView()
                tutorial.present(with: presenter, in: vc, from: view)
                expect(presenter.presentInvokeCount).to(equal(1))
                expect(presenter.presentInvokeTutorials[0]).to(be(tutorial))
                expect(presenter.presentInvokeVcs).to(equal([vc]))
                expect(presenter.presentInvokeViews).to(equal([view]))
            }
        }
    }
}
