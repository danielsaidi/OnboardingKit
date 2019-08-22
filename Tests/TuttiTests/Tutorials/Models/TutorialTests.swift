//
//  TutorialTests.swift
//  TuttiTests
//
//  Created by Daniel Saidi on 2017-12-06.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import Tutti

class TutorialTests: QuickSpec {
    
    override func spec() {
        
        context("current page") {
            
            func getTutorial(_ pageCount: Int, _ pageIndex: Int) -> Tutorial {
                let tutorial = StandardTutorial(identifier: "foo", pageCount: pageCount)
                tutorial.currentPageIndex = pageIndex
                return tutorial
            }
            
            describe("is first page") {
                
                it("is true if page count is zero") {
                    expect(getTutorial(0, 0).isFirstPage).to(beTrue())
                }
                
                it("is true if current page index is zero") {
                    expect(getTutorial(1, 0).isFirstPage).to(beTrue())
                }
                
                it("is false if current page index is not zero") {
                    expect(getTutorial(2, 1).isFirstPage).to(beFalse())
                }
            }
            
            describe("is last page") {
                
                it("is true if page count is zero") {
                    expect(getTutorial(0, 0).isLastPage).to(beTrue())
                }
                
                it("is true if current page is only page") {
                    expect(getTutorial(1, 0).isLastPage).to(beTrue())
                }
                
                it("is true if current page index is last") {
                    expect(getTutorial(2, 1).isLastPage).to(beTrue())
                }
                
                it("is false if current page index is not last") {
                    expect(getTutorial(2, 0).isLastPage).to(beFalse())
                }
            }
        }
        
        
        context("translations") {
            
            func getTutorial() -> Tutorial {
                return StandardTutorial(identifier: "foo", pageCount: 0)
            }
            
            describe("translate") {
                
                it("returns translated key") {
                    // TODO: The is no bundle and thus no localizations when you use SPM
                    // let translation = getTutorial().translate("tutorial_standard_0_title")
                    // expect(translation).to(equal("Standard tutorials"))
                }
                
                it("returns key if translation does not exist") {
                    let translation = getTutorial().translate("foo")
                    expect(translation).to(equal("foo"))
                }
            }
            
            describe("translation exists") {
                
                it("returns true if key exists") {
                    // TODO: The is no bundle and thus no localizations when you use SPM
                    // let exists = getTutorial().translationExists(for: "tutorial_standard_0_title")
                    // expect(exists).to(beTrue())
                }
                
                it("returns false if key does not exist") {
                    let exists = getTutorial().translationExists(for: "foo")
                    expect(exists).to(beFalse())
                }
            }
        }
    }
}
