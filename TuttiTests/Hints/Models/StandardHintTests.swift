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
        
        
        describe("when presenting") {
            
            beforeEach {
                hint = createHint()
            }
            
            it("aborts if it has already been displayed") {
                persistence.boolValues[hint.hasBeenDisplayedKey] = true
                hint.present(with: presenter, in: UIViewController(), from: UIView())
                expect(persistence.setBoolInvokeCount).to(equal(0))
                expect(presenter.presentInvokeCount).to(equal(0))
            }
            
            it("sets has been displayed") {
                hint.present(with: presenter, in: UIViewController(), from: UIView())
                expect(persistence.setBoolInvokeCount).to(equal(1))
                expect(persistence.setBoolInvokeKeys).to(equal([hint.hasBeenDisplayedKey]))
                expect(persistence.setBoolInvokeValues).to(equal([true]))
            }
            
            it("asks presenter to present it from valid context") {
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
