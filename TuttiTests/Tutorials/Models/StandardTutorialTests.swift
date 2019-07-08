//
//  StandardTutorialTests.swift
//  TuttiTests
//
//  Created by Daniel Saidi on 2017-12-06.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
@testable import Tutti

class StandardTutorialTests: QuickSpec {
    
    override func spec() {
        
        var persistence: MockOnboardingPersistence!
        var presenter: MockTutorialPresenter!
        
        beforeEach {
            persistence = MockOnboardingPersistence()
            presenter = MockTutorialPresenter()
        }
        
        
        describe("when created") {
            
            context("with parameters") {
                
                it("sets all properties") {
                    let tutorial = StandardTutorial(identifier: "foo", pageCount: 12, userId: "bar")
                    expect(tutorial.identifier).to(equal("foo"))
                    expect(tutorial.userId).to(equal("bar"))
                    expect(tutorial.pageCount).to(equal(12))
                }
            }
            
            context("from localization") {
                
                it("has zero pages if no translation was found") {
                    let tutorial = StandardTutorial(fromLocalizationWithPageIndicationKey: "title", identifier: "nonExisting", userId: "bar")
                    expect(tutorial.pageCount).to(equal(0))
                }
                
                it("has a single page if no translation sequence was found") {
                    let tutorial = StandardTutorial(fromLocalizationWithPageIndicationKey: "title", identifier: "test_onePage", userId: "bar")
                    expect(tutorial.pageCount).to(equal(1))
                }

                it("has multiple pages if a translation sequence was found") {
                    let tutorial = StandardTutorial(fromLocalizationWithPageIndicationKey: "title", identifier: "test_sixPages", userId: "bar")
                    expect(tutorial.pageCount).to(equal(6))
                }

                it("uses custom key segment separator") {
                    let tutorial = StandardTutorial(fromLocalizationWithPageIndicationKey: "title", identifier: "test*customKeySegmentSeparator", userId: "bar", keySegmentSeparator: "*")
                    expect(tutorial.pageCount).to(equal(2))
                }

                it("uses custom page indicator key") {
                    let tutorial = StandardTutorial(fromLocalizationWithPageIndicationKey: "page", identifier: "test_customPageIndicator", userId: "bar")
                    expect(tutorial.pageCount).to(equal(2))
                }
            }
        }
        
        describe("loading next page") {
            
            it("always fails if page count is zero") {
                let tutorial = StandardTutorial(identifier: "foo", pageCount: 0, userId: "bar")
                expect(tutorial.loadNextPage()).to(beFalse())
                expect(tutorial.currentPageIndex).to(equal(0))
            }
            
            it("fails if tutorial is at last page") {
                let tutorial = StandardTutorial(identifier: "foo", pageCount: 1, userId: "bar")
                expect(tutorial.loadNextPage()).to(beFalse())
                expect(tutorial.currentPageIndex).to(equal(0))
            }
            
            it("succeeds if tutorial is not at last page") {
                let tutorial = StandardTutorial(identifier: "foo", pageCount: 2, userId: "bar")
                expect(tutorial.loadNextPage()).to(beTrue())
                expect(tutorial.currentPageIndex).to(equal(1))
            }
        }
        
        describe("loading previous page") {
            
            it("always fails if page count is zero") {
                let tutorial = StandardTutorial(identifier: "foo", pageCount: 0, userId: "bar")
                expect(tutorial.loadPreviousPage()).to(beFalse())
                expect(tutorial.currentPageIndex).to(equal(0))
            }
            
            it("fails if tutorial is at first page") {
                let tutorial = StandardTutorial(identifier: "foo", pageCount: 1, userId: "bar")
                expect(tutorial.loadPreviousPage()).to(beFalse())
                expect(tutorial.currentPageIndex).to(equal(0))
            }
            
            it("succeeds if tutorial is not at first page") {
                let tutorial = StandardTutorial(identifier: "foo", pageCount: 3, userId: "bar")
                _ = tutorial.loadNextPage()
                _ = tutorial.loadNextPage()
                expect(tutorial.loadPreviousPage()).to(beTrue())
                expect(tutorial.currentPageIndex).to(equal(1))
            }
        }
        
        describe("resource name at page index") {
            
            it("ignores empty key") {
                let tutorial = StandardTutorial(identifier: "foo", pageCount: 1, userId: "bar")
                let name = tutorial.resourceName(for: "", at: 0)
                expect(name).to(equal("tutorial_foo_0"))
            }
            
            it("adds non-empty key") {
                let tutorial = StandardTutorial(identifier: "foo", pageCount: 1, userId: "bar")
                let name = tutorial.resourceName(for: "bar", at: 0)
                expect(name).to(equal("tutorial_foo_0_bar"))
            }
            
            it("applies current page index") {
                let tutorial = StandardTutorial(identifier: "foo", pageCount: 3, userId: "bar")
                let name = tutorial.resourceName(for: "bar", at: 2)
                expect(name).to(equal("tutorial_foo_2_bar"))
            }
            
            it("uses custom key segment separator") {
                let tutorial = StandardTutorial(identifier: "foo", pageCount: 0, userId: "bar", keySegmentSeparator: "===")
                let name = tutorial.resourceName(for: "bar", at: 0)
                expect(name).to(equal("tutorial===foo===0===bar"))
            }
        }
        
        
        describe("should be presented") {
            
            func createTutorial() -> StandardTutorial {
                return StandardTutorial(identifier: "foo", pageCount: 1, persistence: persistence)
            }
            
            it("should be if it hasn't been displayed") {
                let tutorial = createTutorial()
                expect(tutorial.shouldBePresented).to(beTrue())
            }
            
            it("should not be if it has been displayed") {
                let tutorial = createTutorial()
                persistence.boolValues[tutorial.hasBeenDisplayedKey] = true
                expect(tutorial.shouldBePresented).to(beFalse())
            }
        }
    }
}
