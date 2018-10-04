//
//  StandardHintTests.swift
//  TuttiTests
//
//  Created by Daniel Saidi on 2017-12-06.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
@testable import Tutti

class StandardHintTests: QuickSpec {
    
    override func spec() {
        
        var hint: StandardHint!
        var persistence: MockOnboardingPersistence!
        var presenter: MockHintPresenter!
        
        beforeEach {
            persistence = MockOnboardingPersistence()
            presenter = MockHintPresenter()
            hint = createHint()
        }
        
        func createHint() -> StandardHint {
            return StandardHint(
                identifier: "hint",
                title: "foo",
                text: "bar",
                userId: "baz",
                persistence: persistence)
        }
        
        
        describe("when created") {
            
            it("sets all properties") {
                hint = createHint()
                expect(hint.identifier).to(equal("hint"))
                expect(hint.title).to(equal("foo"))
                expect(hint.text).to(equal("bar"))
                expect(hint.userId).to(equal("baz"))
                expect(hint.persistence).to(be(persistence))
            }
            
            it("uses user default persistence by default") {
                hint = StandardHint(identifier: "", title: "", text: "", userId: "")
                expect(hint.persistence).to(be(UserDefaults.standard))
            }
        }

        
        describe("should be presented") {
            
            it("should be if it hasn't been displayed") {
                expect(hint.shouldBePresented).to(beTrue())
            }
            
            it("should not be if it has been displayed") {
                persistence.boolValues[hint.hasBeenDisplayedKey] = true
                expect(hint.shouldBePresented).to(beFalse())
            }
        }
    }
}
