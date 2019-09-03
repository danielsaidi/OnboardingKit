//
//  StandardTutorial.swift
//  Tutti
//
//  Created by Daniel Saidi on 2017-12-03.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This is a basic tutorial implementation that can be used as
 is or inherited to create custom tutorials. You can present
 it using any presenter.
 
 You can create a standard tutorial (as well as any tutorial
 that inherits this class) by either:
 
 * using the main initializer, that requires you to manually
 specify all properties, such as identifier, page count etc.
 * using the localization-based initializer, which uses your
 app's localization to resolve the page count automatically.
 
 The localization-based approach requires a "page indication
 key", which it uses it to calculate the number of pages for
 the tutorial. It increases the number of pages as long as a
 translation exists for `resourceName(for: "title", at: ...)`.
 
 Given the standard resource name pattern used by this class,
 the tutorial-based initialized will setup a tutorial with a
 "myTutorial" identifier with two pages, if the localization
 file contains the following two language keys:
 
 * `tutorial_myTutorial_0_title`
 * `tutorial_myTutorial_1_title`
 
 You can subclass this class and override the initializer if
 you want this automatic handling to behave differently.
 */
open class StandardTutorial: Tutorial {
    
    
    // MARK: - Initialization
    
    public init(
        identifier: String,
        pageCount: Int,
        userId: String? = nil,
        keySegmentSeparator: String = "_",
        persistence: OnboardingPersistence = UserDefaults.standard) {
        self.identifier = identifier
        self.pageCount = pageCount
        self.userId = userId
        self.keySegmentSeparator = keySegmentSeparator
        self.persistence = persistence
    }
    
    public init(
        fromLocalizationWithPageIndicationKey key: String = "title",
        identifier: String,
        userId: String? = nil,
        keySegmentSeparator: String = "_",
        persistence: OnboardingPersistence = UserDefaults.standard) {
        self.identifier = identifier
        self.pageCount = -1
        self.userId = userId
        self.keySegmentSeparator = keySegmentSeparator
        self.persistence = persistence
        self.pageCount = resolvePageCount(withPageIndicationKey: key)
    }
    
    
    // MARK: - Properties
    
    public let identifier: String
    public let keySegmentSeparator: String
    public var pageCount: Int
    public let userId: String?
    
    public var currentPageIndex = 0
    
    public var persistence: OnboardingPersistence
    
    public var shouldBePresented: Bool {
        return !hasBeenDisplayed
    }
    
    
    // MARK: Public functions
    
    open func loadNextPage() -> Bool {
        if isLastPage { return false }
        currentPageIndex += 1
        return true
    }
    
    open func loadPreviousPage() -> Bool {
        if isFirstPage { return false }
        currentPageIndex -= 1
        return true
    }
    
    open func prepareForPresentation() {}
    
    open func resourceName(for key: String, at pageIndex: Int) -> String {
        let key = key.trimmingCharacters(in: .whitespaces)
        var segments = ["tutorial", identifier, "\(pageIndex)"]
        if key.count > 0 { segments.append(key) }
        return segments.joined(separator: keySegmentSeparator)
    }
}


// MARK: - Private Functions

private extension StandardTutorial {
    
    func resolvePageCount(withPageIndicationKey key: String) -> Int {
        var index = 0
        var resource = resourceName(for: key, at: index)
        while translationExists(for: resource) {
            index += 1
            resource = resourceName(for: key, at: index)
        }
        return index
    }
}
