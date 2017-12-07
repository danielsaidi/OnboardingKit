//
//  TutorialPresenterBaseTests.swift
//  TuttiTests
//
//  Created by Daniel Saidi on 2017-12-07.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import Tutti

class TutorialPresenterBaseTests: QuickSpec {
    
    override func spec() {
        
        var tutorial: Tutorial!
        var presenter: TutorialPresenter!
        
        beforeEach {
            tutorial = StandardTutorial(identifier: "foo", pageCount: 0)
            presenter = TutorialPresenterBase()
        }
        
        afterEach {
            tutorial.hasBeenDisplayed = false
        }
        
        describe("presenting a hint") {
            
            it("succeeds if the tutorial has not already been displayed") {
                let result = presenter.present(tutorial: tutorial, in: UIViewController(), from: UIView())
                expect(result).to(beTrue())
            }
            
            it("fails if the tutorial has already been displayed") {
                tutorial.hasBeenDisplayed = true
                let result = presenter.present(tutorial: tutorial, in: UIViewController(), from: UIView())
                expect(result).to(beFalse())
            }
            
            it("fails to present the same tutorial multiple times") {
                let result1 = presenter.present(tutorial: tutorial, in: UIViewController(), from: UIView())
                let result2 = presenter.present(tutorial: tutorial, in: UIViewController(), from: UIView())
                expect(result1).to(beTrue())
                expect(result2).to(beFalse())
            }
        }
    }
}
