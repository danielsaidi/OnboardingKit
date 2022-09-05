//
//  HintTests.swift
//  TuttiTests
//
//  Created by Daniel Saidi on 2020-09-09.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Tutti
import XCTest

final class HintTests: XCTestCase {

    func test_hasTitle_isTrueIfTitleHasContent() {
        XCTAssertTrue(Hint(title: " Hi! ", text: "").hasTitle)
        XCTAssertFalse(Hint(title: "     ", text: "").hasTitle)
    }

    func test_equality_isEqualIfBothTitleAndTextMatches() {
        let hint1 = Hint(title: "1", text: "1")
        let hint2 = Hint(title: "1", text: "2")
        let hint3 = Hint(title: "2", text: "1")
        let hint4 = Hint(title: "1", text: "1")
        XCTAssertTrue(hint1 == hint4)
        XCTAssertFalse(hint1 == hint2)
        XCTAssertFalse(hint1 == hint3)
        XCTAssertFalse(hint2 == hint3)
    }
}
