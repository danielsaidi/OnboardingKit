//
//  TutorialPageInfo.swift
//  
//
//  Created by Daniel Saidi on 2022-09-05.
//

import Foundation

/**
 This type can be used to provide info about a tutorial page.

 This struct can be used in various scenarios, to be able to
 extend the provided page information later without changing
 the signatures of e.g. various view builders.
 */
public struct TutorialPageInfo {

    /// The current page index.
    public let pageIndex: Int

    /// The total number of pages.
    public let totalPageCount: Int
}

public extension TutorialPageInfo {

    /// Whether or not this is the first page.
    var isFirstPage: Bool {
        pageIndex == 0
    }

    /// Whether or not this is the last page.
    var isLastPage: Bool {
        pageIndex < totalPageCount - 1
    }

    /// Whether or not the provided page is the current page.
    func isCurrentPage(_ pageIndex: Int) -> Bool {
        pageIndex == self.pageIndex
    }
}
