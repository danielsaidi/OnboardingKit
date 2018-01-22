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
}
