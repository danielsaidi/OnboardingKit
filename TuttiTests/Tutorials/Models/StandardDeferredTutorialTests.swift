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
        
        var tutorial: StandardDeferredTutorial!
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
                tutorial = createTutorial(requiredPresentationAttempts: 3)
                expect(tutorial.identifier).to(equal("foo"))
                expect(tutorial.pageCount).to(equal(3))
                expect(tutorial.requiredPresentationAttempts).to(equal(3))
                expect(tutorial.userId).to(equal("bar"))
                expect(tutorial.keySegmentSeparator).to(equal("baz"))
                expect(tutorial.persistence).to(be(persistence))
            }
            
            it("uses user default persistence by default") {
                tutorial = StandardDeferredTutorial(identifier: "", pageCount: 1, requiredPresentationAttempts: 121)
                expect(tutorial.persistence).to(be(UserDefaults.standard))
            }
        }
        
        
        describe("when presenting") {
            
            beforeEach {
                tutorial = createTutorial(requiredPresentationAttempts: 10)
            }
            
            it("registers presentation attempt") {
                persistence.intValues[tutorial.registeredPresentationAttemptsKey] = 2
                tutorial.present(with: presenter, in: UIViewController(), from: UIView())
                expect(persistence.setIntInvokeCount).to(equal(1))
                expect(persistence.setIntInvokeValues).to(equal([3]))
                expect(persistence.setIntInvokeKeys).to(equal([tutorial.registeredPresentationAttemptsKey]))
            }
            
            it("aborts if it shouldn't be presented") {
                tutorial.present(with: presenter, in: UIViewController(), from: UIView())
                expect(presenter.presentInvokeCount).to(equal(0))
            }
            
            it("asks presenter to present it from valid context") {
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
