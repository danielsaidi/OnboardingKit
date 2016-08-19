//
//  Tutorial.swift
//  Tutti
//
//  Created by Daniel Saidi on 2015-04-16.
//  Copyright (c) 2015 Daniel Saidi. All rights reserved.
//

import UIKit

@objc public protocol Tutorial {
    
    var identifier: String { get }
    
    var currentPageIndex: Int { get }
    var hasBeenDisplayed: Bool { get set }
    var isFirstPage: Bool { get }
    var isLastPage: Bool { get }
    var pageCount: Int { get }
    
    func getResourceName(key: String) -> String
    func next() -> Bool
    func previous() -> Bool
}
