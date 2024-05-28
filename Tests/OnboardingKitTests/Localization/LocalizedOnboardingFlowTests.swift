//
//  LocalizedOnboardingTests.swift
//  OnboardingKitTests
//
//  Created by Daniel Saidi on 2018-06-18.
//  Copyright © 2018-2024 Daniel Saidi. All rights reserved.
//

import OnboardingKit
import XCTest

final class LocalizedOnboardingTests: XCTestCase {

    func test_standardInitializer_createsStandardPagesForAllTranslations() {
        let translator: (String) -> String = {
            $0 == "onboarding.welcome.3.title" ? $0 : ""
        }

        let result = LocalizedOnboarding(
            id: "welcome",
            translator: translator)
        let pages = result.pages

        XCTAssertEqual(pages.count, 3)
        XCTAssertEqual(pages[0].title, "onboarding.welcome.0.title")
        XCTAssertEqual(pages[1].text, "onboarding.welcome.1.text")
        XCTAssertEqual(pages[2].imageName, "onboarding.welcome.2.image")
    }

    func test_customInitializer_createsStandardPagesForAllTranslations() {
        let translator: (String) -> String = {
            $0 == "onboarding_custom_2_movie" ? $0 : ""
        }

        let result = LocalizedOnboarding(
            id: "custom",
            pageIndicationKey: "movie",
            resourceKeySeparator: "_",
            translator: translator)
        let pages = result.pages

        XCTAssertEqual(pages.count, 2)
        XCTAssertEqual(pages[0].title, "onboarding_custom_0_title")
        XCTAssertEqual(pages[1].text, "onboarding_custom_1_text")
    }

    func test_standardResourceNameResolver_usesExpectedResourceNameFormat() {
        let result = LocalizedOnboarding.resourceName(
            for: "welcome",
            at: 0,
            key: "title",
            keySeparator: "-")
        XCTAssertEqual(result, "onboarding-welcome-0-title")
    }

    func test_standardResourceNameResolver_omitsEmptyResourceKeys() {
        let result = LocalizedOnboarding.resourceName(
            for: "farewell",
            at: 3,
            key: "",
            keySeparator: "*")
        XCTAssertEqual(result, "onboarding*farewell*3")
    }

    func test_standardPageResolved_usesProvidedResourceNameResolved() {
        let result = LocalizedOnboarding.page(
            for: "hello",
            at: 5,
            in: .main,
            resourceName: LocalizedOnboarding.resourceName,
            resourceKeySeparator: "_")
        XCTAssertEqual(result.title, "onboarding_hello_5_title")
        XCTAssertEqual(result.text, "onboarding_hello_5_text")
        XCTAssertEqual(result.imageName, "onboarding_hello_5_image")
    }
}
