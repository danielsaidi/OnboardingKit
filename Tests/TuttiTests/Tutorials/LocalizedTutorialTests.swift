//
//  LocalizedTutorialTests.swift
//  TuttiTests
//
//  Created by Daniel Saidi on 2018-06-18.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Tutti

class LocalizedTutorialTests: QuickSpec {

    override func spec() {
        
        describe("standard initializer") {
            
            let translator: (String) -> String = {
                let stop = $0 == "tutorial.welcome.3.title"
                return stop ? $0 : ""
            }
            
            it("creates standard pages until no translation is found") {
                let result = LocalizedTutorial(id: "welcome", translator: translator)
                let pages = result.pages
                expect(pages.count).to(equal(3))
                expect(pages[0].title).to(equal("tutorial.welcome.0.title"))
                expect(pages[1].text).to(equal("tutorial.welcome.1.text"))
                expect(pages[2].imageName).to(equal("tutorial.welcome.2.image"))
            }
        }
        
        describe("custom initializer") {
            
            let translator: (String) -> String = {
                let stop = $0 == "tutorial_custom_2_movie"
                return stop ? $0 : ""
            }
            
            it("creates standard pages until no translation is found") {
                let result = LocalizedTutorial(
                    id: "custom",
                    pageIndicationKey: "movie",
                    resourceKeySeparator: "_",
                    translator: translator)
                let pages = result.pages
                expect(pages.count).to(equal(2))
                expect(pages[0].title).to(equal("tutorial_custom_0_title"))
                expect(pages[1].text).to(equal("tutorial_custom_1_text"))
            }
        }
        
        describe("standard resource name resolver") {
            
            it("uses the expected resource name format") {
                let result = LocalizedTutorial.resourceName(
                    for: "welcome",
                    at: 0,
                    resourceKey: "title",
                    resourceKeySeparator: "-")
                expect(result).to(equal("tutorial-welcome-0-title"))
            }
            
            it("omits empty resource keys") {
                let result = LocalizedTutorial.resourceName(
                    for: "farewell",
                    at: 3,
                    resourceKey: "",
                    resourceKeySeparator: "*")
                expect(result).to(equal("tutorial*farewell*3"))
            }
        }
        
        describe("standard page resolver") {
            
            it("uses the provided resource name resolver") {
                let result = LocalizedTutorial.page(
                    for: "hello",
                    at: 5,
                    resourceName: LocalizedTutorial.resourceName,
                    resourceKeySeparator: "_")
                expect(result.title).to(equal("tutorial_hello_5_title"))
                expect(result.text).to(equal("tutorial_hello_5_text"))
                expect(result.imageName).to(equal("tutorial_hello_5_image"))
            }
        }
    }
}
