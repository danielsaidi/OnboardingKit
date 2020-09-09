//
//  HintTests.swift
//  TuttiTests
//
//  Created by Daniel Saidi on 2020-09-09.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Tutti

class HintTests: QuickSpec {

    override func spec() {

        describe("has title") {
            
            it("is true if hint title has content") {
                expect(Hint(title: " Hi! ", text: "").hasTitle).to(beTrue())
                expect(Hint(title: "     ", text: "").hasTitle).to(beFalse())
            }
        }

        describe("equality") {
            
            it("is true if both title and text matches") {
                let hint1 = Hint(title: "1", text: "1")
                let hint2 = Hint(title: "1", text: "2")
                let hint3 = Hint(title: "2", text: "1")
                let hint4 = Hint(title: "1", text: "1")
                expect(hint1).toNot(equal(hint2))
                expect(hint1).toNot(equal(hint3))
                expect(hint1).to(equal(hint4))
            }
        }
    }
}
