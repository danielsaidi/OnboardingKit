//
//  OnboardingPageInfo.swift
//  OnboardingKitTests
//
//  Created by Daniel Saidi on 2018-06-18.
//  Copyright © 2018-2025 Daniel Saidi. All rights reserved.
//

import OnboardingKit
import XCTest

final class InfoTests: XCTestCase {
    
    typealias Info = OnboardingPageInfo

    func test_isFirstPage_returnsCorrectResult() {
        let obj1 = Info(page: -1, pageIndex: -1, currentPageIndex: 0, totalPageCount: 10)
        let obj2 = Info(page: 0, pageIndex: 0, currentPageIndex: 0, totalPageCount: 10)
        let obj3 = Info(page: 1, pageIndex: 1, currentPageIndex: 0, totalPageCount: 10)

        XCTAssertTrue(obj1.isFirstPage)
        XCTAssertTrue(obj2.isFirstPage)
        XCTAssertFalse(obj3.isFirstPage)
    }

    func test_isLastPage_returnsCorrectResult() {
        let obj1 = Info(page: 0, pageIndex: 0, currentPageIndex: 0, totalPageCount: 10)
        let obj2 = Info(page: 10, pageIndex: 10, currentPageIndex: 0, totalPageCount: 10)
        let obj3 = Info(page: 11, pageIndex: 11, currentPageIndex: 0, totalPageCount: 10)

        XCTAssertFalse(obj1.isLastPage)
        XCTAssertTrue(obj2.isLastPage)
        XCTAssertTrue(obj3.isLastPage)
    }

    func test_isCurrentPage_returnsCorrectResult() {
        let obj1 = Info(page: 0, pageIndex: 0, currentPageIndex: 5, totalPageCount: 10)
        let obj2 = Info(page: 10, pageIndex: 10, currentPageIndex: 10, totalPageCount: 10)

        XCTAssertFalse(obj1.isCurrentPage)
        XCTAssertTrue(obj2.isCurrentPage)
    }
}
