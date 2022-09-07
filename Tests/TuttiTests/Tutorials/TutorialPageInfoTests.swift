//
//  TutorialPageInfoTests.swift
//  TuttiTests
//
//  Created by Daniel Saidi on 2018-06-18.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Tutti
import XCTest

final class TutorialPageInfoTests: XCTestCase {

    func test_isFirstPage_returnsCorrectResult() {
        let obj1 = TutorialPageInfo(pageIndex: -1, currentPageIndex: 0, totalPageCount: 10)
        let obj2 = TutorialPageInfo(pageIndex: 0, currentPageIndex: 0, totalPageCount: 10)
        let obj3 = TutorialPageInfo(pageIndex: 1, currentPageIndex: 0, totalPageCount: 10)

        XCTAssertTrue(obj1.isFirstPage)
        XCTAssertTrue(obj2.isFirstPage)
        XCTAssertFalse(obj3.isFirstPage)
    }

    func test_isLastPage_returnsCorrectResult() {
        let obj1 = TutorialPageInfo(pageIndex: 0, currentPageIndex: 0, totalPageCount: 10)
        let obj2 = TutorialPageInfo(pageIndex: 10, currentPageIndex: 0, totalPageCount: 10)
        let obj3 = TutorialPageInfo(pageIndex: 11, currentPageIndex: 0, totalPageCount: 10)

        XCTAssertFalse(obj1.isLastPage)
        XCTAssertTrue(obj2.isLastPage)
        XCTAssertTrue(obj3.isLastPage)
    }

    func test_isCurrentPage_returnsCorrectResult() {
        let obj1 = TutorialPageInfo(pageIndex: 0, currentPageIndex: 5, totalPageCount: 10)
        let obj2 = TutorialPageInfo(pageIndex: 10, currentPageIndex: 10, totalPageCount: 10)

        XCTAssertFalse(obj1.isCurrentPage)
        XCTAssertTrue(obj2.isCurrentPage)
    }
}
