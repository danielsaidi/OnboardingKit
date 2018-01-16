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

fileprivate class TestTutorial: Tutorial {
    
    init(currentPage: Int, pageCount: Int) {
        self.currentPageIndex = currentPage
        self.pageCount = pageCount
    }
    
    weak var presenter: TutorialPresenter?
    
    let identifier = "foo"
    let userId: String? = "bar"
    
    var currentPageIndex: Int
    var pageCount: Int
    
    func loadNextPage() -> Bool { return false }
    func loadPreviousPage() -> Bool { return false }
    func resourceName(for key: String) -> String { return "" }
}


class TutorialTests: QuickSpec {
    
    override func spec() {
        
        describe("is first page") {
            
            it("is true if page count is zero") {
                let tutorial = TestTutorial(currentPage: 0, pageCount: 0)
                expect(tutorial.isFirstPage).to(beTrue())
            }
            
            it("is true if current page index is zero") {
                let tutorial = TestTutorial(currentPage: 0, pageCount: 1)
                expect(tutorial.isFirstPage).to(beTrue())
            }
            
            it("is false if current page index is not zero") {
                let tutorial = TestTutorial(currentPage: 1, pageCount: 1)
                expect(tutorial.isFirstPage).to(beFalse())
            }
        }
        
        
        describe("is last page") {
            
            it("is true if page count is zero") {
                let tutorial = TestTutorial(currentPage: 0, pageCount: 0)
                expect(tutorial.isLastPage).to(beTrue())
            }
            
            it("is true if current page is only page") {
                let tutorial = TestTutorial(currentPage: 0, pageCount: 1)
                expect(tutorial.isLastPage).to(beTrue())
            }
            
            it("is false if current page index is not last") {
                let tutorial = TestTutorial(currentPage: 0, pageCount: 2)
                expect(tutorial.isLastPage).to(beFalse())
            }
            
            it("is false if current page index is last") {
                let tutorial = TestTutorial(currentPage: 1, pageCount: 2)
                expect(tutorial.isLastPage).to(beTrue())
            }
        }
    }
}

