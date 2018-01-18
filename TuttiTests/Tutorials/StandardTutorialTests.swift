//
//  StandardTutorialTests.swift
//  TuttiTests
//
//  Created by Daniel Saidi on 2017-12-06.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import Tutti

class StandardTutorialTests: QuickSpec {
    
    override func spec() {
        
        func createTutorial(
            pageCount: Int = 0,
            keySegmentSeparator: String? = nil) -> StandardTutorial {
            return StandardTutorial(
                identifier: "foo",
                pageCount: pageCount,
                userId: "bar")
        }
        
        func createTutorial(keySegmentSeparator: String) -> StandardTutorial {
            return StandardTutorial(
                identifier: "foo",
                pageCount: 0,
                userId: "bar",
                keySegmentSeparator: keySegmentSeparator)
        }
        
        describe("creating a standard tutorial") {
            
            it("sets all properties") {
                let tutorial = createTutorial()
                expect(tutorial.identifier).to(equal("foo"))
                expect(tutorial.userId).to(equal("bar"))
            }
        }
        
        describe("loading next page") {
            
            it("always fails if page count is zero") {
                let tutorial = createTutorial()
                let result = tutorial.loadNextPage()
                expect(result).to(beFalse())
                expect(tutorial.currentPageIndex).to(equal(0))
            }
            
            it("fails if tutorial is at last page") {
                let tutorial = createTutorial(pageCount: 1)
                let result = tutorial.loadNextPage()
                expect(result).to(beFalse())
                expect(tutorial.currentPageIndex).to(equal(0))
            }
            
            it("succeeds if tutorial is not at last page") {
                let tutorial = createTutorial(pageCount: 2)
                let result = tutorial.loadNextPage()
                expect(result).to(beTrue())
                expect(tutorial.currentPageIndex).to(equal(1))
            }
        }
        
        describe("loading previous page") {
            
            it("always fails if page count is zero") {
                let tutorial = createTutorial()
                let result = tutorial.loadPreviousPage()
                expect(result).to(beFalse())
                expect(tutorial.currentPageIndex).to(equal(0))
            }
            
            it("fails if tutorial is at first page") {
                let tutorial = createTutorial(pageCount: 1)
                let result = tutorial.loadPreviousPage()
                expect(result).to(beFalse())
                expect(tutorial.currentPageIndex).to(equal(0))
            }
            
            it("succeeds if tutorial is not at last page") {
                let tutorial = createTutorial(pageCount: 3)
                _ = tutorial.loadNextPage()
                _ = tutorial.loadNextPage()
                let result = tutorial.loadPreviousPage()
                expect(result).to(beTrue())
                expect(tutorial.currentPageIndex).to(equal(1))
            }
        }
        
        describe("resource name") {
            
            it("omits empty key") {
                let tutorial = createTutorial()
                let name = tutorial.resourceName(for: "")
                expect(name).to(equal("tutorial_foo_0"))
            }
            
            it("adds non-empty key") {
                let tutorial = createTutorial()
                let name = tutorial.resourceName(for: "bar")
                expect(name).to(equal("tutorial_foo_0_bar"))
            }
            
            it("applies current page index") {
                let tutorial = createTutorial(pageCount: 3)
                _ = tutorial.loadNextPage()
                _ = tutorial.loadNextPage()
                let name = tutorial.resourceName(for: "bar")
                expect(name).to(equal("tutorial_foo_2_bar"))
            }
            
            it("uses custom key segment separator") {
                let tutorial = createTutorial(keySegmentSeparator: "===")
                let name = tutorial.resourceName(for: "bar")
                expect(name).to(equal("tutorial===foo===0===bar"))
            }
        }
    }
}
