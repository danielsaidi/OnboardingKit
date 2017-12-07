//
//  HintPresenterBaseTests.swift
//  TuttiTests
//
//  Created by Daniel Saidi on 2017-12-07.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import Tutti

class HintPresenterBaseTests: QuickSpec {
    
    override func spec() {
        
        var hint: Hint!
        var presenter: HintPresenter!
        
        beforeEach {
            hint = StandardHint(identifier: "foo", text: "bar")
            presenter = HintPresenterBase()
        }
        
        afterEach {
            hint.hasBeenDisplayed = false
        }
        
        describe("presenting a hint") {
            
            it("succeeds if the hint has not already been displayed") {
                let result = presenter.present(hint: hint, in: UIViewController(), from: UIView())
                expect(result).to(beTrue())
            }
            
            it("fails if the hint has already been displayed") {
                hint.hasBeenDisplayed = true
                let result = presenter.present(hint: hint, in: UIViewController(), from: UIView())
                expect(result).to(beFalse())
            }
            
            it("fails to present the same hint multiple times") {
                let result1 = presenter.present(hint: hint, in: UIViewController(), from: UIView())
                let result2 = presenter.present(hint: hint, in: UIViewController(), from: UIView())
                expect(result1).to(beTrue())
                expect(result2).to(beFalse())
            }
        }
    }
}

