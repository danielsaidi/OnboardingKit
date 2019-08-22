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
import Foundation
import UIKit

class StandardDeferredHintTests: QuickSpec {
    
    override func spec() {
        
        var persistence: MockOnboardingPersistence!
        var presenter: MockHintPresenter!
        
        beforeEach {
            persistence = MockOnboardingPersistence()
            presenter = MockHintPresenter()
        }
        
        func createHint(requiredPresentationAttempts: Int) -> DeferredHint {
            return DeferredHint(
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
                let hint = DeferredHint(identifier: "", title: "", text: "", requiredPresentationAttempts: 121, userId: "")
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
    }
}
