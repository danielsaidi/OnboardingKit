//
//  StandardDeferredHintTests.swift
//  TuttiTests
//
//  Created by Daniel Saidi on 2018-06-19.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
@testable import Tutti

class StandardDeferredHintTests: QuickSpec {
    
    override func spec() {
        
        var persistence: MockOnboardingPersistence!
        var presenter: MockHintPresenter!
        
        beforeEach {
            persistence = MockOnboardingPersistence()
            presenter = MockHintPresenter()
        }
        
        func createHint(requiredPresentationAttempts: Int) -> StandardDeferredHint {
            return StandardDeferredHint(
                identifier: "hint",
                title: "foo",
                text: "bar",
                requiredPresentationAttempts: requiredPresentationAttempts,
                userId: "baz",
                persistence: persistence)
        }
        
        
        describe("when created") {
            
            it("sets all properties") {
                let hint = createHint(requiredPresentationAttempts: 3)
                expect(hint.identifier).to(equal("hint"))
                expect(hint.title).to(equal("foo"))
                expect(hint.text).to(equal("bar"))
                expect(hint.requiredPresentationAttempts).to(equal(3))
                expect(hint.userId).to(equal("baz"))
                expect(hint.persistence).to(be(persistence))
            }
            
            it("uses user default persistence by default") {
                let hint = StandardDeferredHint(identifier: "", title: "", text: "", requiredPresentationAttempts: 121, userId: "")
                expect(hint.persistence).to(be(UserDefaults.standard))
            }
        }
    
        
        describe("should be presented") {
            
            it("should be presented if it hasn't been displayed and the remaining presentation attempts is 0") {
                let hint = createHint(requiredPresentationAttempts: 10)
                persistence.intValues[hint.registeredPresentationAttemptsKey] = 10
                expect(hint.shouldBePresented).to(beTrue())
            }
            
            it("should not be presented if it has been displayed") {
                let hint = createHint(requiredPresentationAttempts: 10)
                persistence.boolValues[hint.hasBeenDisplayedKey] = true
                persistence.intValues[hint.registeredPresentationAttemptsKey] = 10
                expect(hint.shouldBePresented).to(beFalse())
            }
            
            it("should not be presented if it has remaining presentation attempts") {
                let hint = createHint(requiredPresentationAttempts: 10)
                persistence.intValues[hint.registeredPresentationAttemptsKey] = 3
                expect(hint.shouldBePresented).to(beFalse())
            }
        }
        
        
        describe("when presenting") {
            
            it("registers presentation attempt") {
                let hint = createHint(requiredPresentationAttempts: 10)
                persistence.intValues[hint.registeredPresentationAttemptsKey] = 2
                hint.present(with: presenter, in: UIViewController(), from: UIView())
                expect(persistence.setIntInvokeCount).to(equal(1))
                expect(persistence.setIntInvokeValues).to(equal([3]))
                expect(persistence.setIntInvokeKeys).to(equal([hint.registeredPresentationAttemptsKey]))
            }
            
            it("aborts if it shouldn't be presented") {
                let hint = createHint(requiredPresentationAttempts: 10)
                hint.present(with: presenter, in: UIViewController(), from: UIView())
                expect(presenter.presentInvokeCount).to(equal(0))
            }
            
            it("asks presenter to present it from valid context") {
                let hint = createHint(requiredPresentationAttempts: 10)
                persistence.intValues[hint.registeredPresentationAttemptsKey] = 10
                let vc = UIViewController()
                let view = UIView()
                hint.present(with: presenter, in: vc, from: view)
                expect(presenter.presentInvokeCount).to(equal(1))
                expect(presenter.presentInvokeHints[0]).to(be(hint))
                expect(presenter.presentInvokeVcs).to(equal([vc]))
                expect(presenter.presentInvokeViews).to(equal([view]))
            }
        }
    }
}
