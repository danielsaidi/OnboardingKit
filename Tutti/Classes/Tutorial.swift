//
//  Tutorial.swift
//  Tutti
//
//  Created by Daniel Saidi on 2015-04-16.
//  Copyright (c) 2015 Daniel Saidi. All rights reserved.
//

/* 
 
 A tutorial is a multi-page guide. Whenever you want the
 app to present multiple pages, e.g. a app start
 
*/

import Foundation

public protocol Tutorial: class {
    
    var identifier: String { get }
    
    var hasBeenDisplayed: Bool { get set }
    var currentPageIndex: Int { get }
    var isFirstPage: Bool { get }
    var isLastPage: Bool { get }
    var pageCount: Int { get }
    
    func getResourceName(key: String) -> String
    func next() -> Bool
    func previous() -> Bool
}
