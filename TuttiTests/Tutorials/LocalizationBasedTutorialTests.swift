//
//  LocalizationBasedTutorialTests.swift
//  TuttiTests
//
//  Created by Daniel Saidi on 2017-12-07.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

/*
 
 This test suite uses localized strings from the hosting app.
 Do not change the test segment in Localizable.strings.
 
 */

@testable import Tutti

import Quick
import Nimble
import Tutti

class LocalizationBasedTutorialTests: QuickSpec {
    
    override func spec() {
        
        describe("creating a localization-based tutorial") {
            
            it("has zero pages if no translation was found") {
                let tutorial = LocalizationBasedTutorial(
                    identifier: "nonExisting")
                expect(tutorial.pageCount).to(equal(0))
            }
            
            it("has a single page if no translation sequence was found") {
                let tutorial = LocalizationBasedTutorial(
                    identifier: "test_onePage")
                expect(tutorial.pageCount).to(equal(1))
            }
            
            it("has multiple pages if a translation sequence was found") {
                let tutorial = LocalizationBasedTutorial(
                    identifier: "test_sixPage")
                expect(tutorial.pageCount).to(equal(6))
            }
            
            it("uses custom key segment separator") {
                let tutorial = LocalizationBasedTutorial(
                    identifier: "test*customKeySegmentSeparator",
                    keySegmentSeparator: "*")
                expect(tutorial.pageCount).to(equal(2))
            }
            
            it("uses custom page indicator key") {
                let tutorial = LocalizationBasedTutorial(
                    identifier: "test_customPageIndicator",
                    pageIndicationKey: "foo")
                expect(tutorial.pageCount).to(equal(3))
            }
        }
    }
}

