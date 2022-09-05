//
//  LocalizedTutorialTests.swift
//  TuttiTests
//
//  Created by Daniel Saidi on 2018-06-18.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Tutti
import XCTest

final class LocalizedTutorialTests: XCTestCase {

    func test_standardInitializer_createsStandardPagesForAllTranslations() {
        let translator: (String) -> String = {
            $0 == "tutorial.welcome.3.title" ? $0 : ""
        }

        let result = LocalizedTutorial(
            id: "welcome",
            translator: translator)
        let pages = result.pages

        XCTAssertEqual(pages.count, 3)
        XCTAssertEqual(pages[0].title, "tutorial.welcome.0.title")
        XCTAssertEqual(pages[1].text, "tutorial.welcome.1.text")
        XCTAssertEqual(pages[2].imageName, "tutorial.welcome.2.image")
    }

    func test_customInitializer_createsStandardPagesForAllTranslations() {
        let translator: (String) -> String = {
            $0 == "tutorial_custom_2_movie" ? $0 : ""
        }

        let result = LocalizedTutorial(
            id: "custom",
            pageIndicationKey: "movie",
            resourceKeySeparator: "_",
            translator: translator)
        let pages = result.pages

        XCTAssertEqual(pages.count, 2)
        XCTAssertEqual(pages[0].title, "tutorial_custom_0_title")
        XCTAssertEqual(pages[1].text, "tutorial_custom_1_text")
    }

    func test_standardResourceNameResolver_usesExpectedResourceNameFormat() {
        let result = LocalizedTutorial.resourceName(
            for: "welcome",
            at: 0,
            resourceKey: "title",
            resourceKeySeparator: "-")
        XCTAssertEqual(result, "tutorial-welcome-0-title")
    }

    func test_standardResourceNameResolver_omitsEmptyResourceKeys() {
        let result = LocalizedTutorial.resourceName(
            for: "farewell",
            at: 3,
            resourceKey: "",
            resourceKeySeparator: "*")
        XCTAssertEqual(result, "tutorial*farewell*3")
    }

    func test_standardPageResolved_usesProvidedResourceNameResolved() {
        let result = LocalizedTutorial.page(
            for: "hello",
            at: 5,
            resourceName: LocalizedTutorial.resourceName,
            resourceKeySeparator: "_")
        XCTAssertEqual(result.title, "tutorial_hello_5_title")
        XCTAssertEqual(result.text, "tutorial_hello_5_text")
        XCTAssertEqual(result.imageName, "tutorial_hello_5_image")
    }
}
