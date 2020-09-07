//
//  LocalizedTutorial.swift
//  Tutti
//
//  Created by Daniel Saidi on 2020-09-06.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 A `LocalizedTutorial` is a regular tutorial, but is created
 by automatically resolving pages based on localized strings,
 instead of providing a fixed set of pages.
 
 This gives you much flexibility, since it lets you manage a
 tutorial by just adding, removing and rearranging localized
 strings and images.
 
 The page resolve functionality may seem complicated, but it
 basically just starts at 0 and checks if a localized string
 exists for a key that is made up by the provided parameters
 and a `pageIndicationKey`. As long as a page exists for the
 key, it appends pages that are created by the `pageResolver`.
 
 If you don't provide a custom `ResourceNameResolver`, `init`
 will apply the static `LocalizedTutorial.resourceName(...)`.
 It generates resource names by starting with "tutorial" and
 then applies the `id`, `page index` and resource "key" then
 finally joins them with `resourceKeySeparator` which is `.`
 by default. This generates a resource names with the format
 `tutorial.<id>.<index>.<key>`.
 
 This means that `title` at `page 2` for a tutorial with the
 id `hello` gets the resource name `tutorial.hello.2.title`.
 
 If you don't provide a `pageResolver` `init` will apply the
 static `LocalizedTutorial.page(...)` which creates standard
 `TutorialPage`s by translating `title` and `text` given the
 `resourceNameResolver`. It also applies the "resource name"
 for `image` as `imageName` for each page.
 */
open class LocalizedTutorial<Page: TutorialPage>: Tutorial<Page> {
    
    /**
     Create a tutorial by automatically creating pages based
     on localized strings.
     
     `translator` is just used for testing purposes although
     you can use it to provide any translation mechanisms if
     you want to.
     */
    public init(
        id: String,
        pageIndicationKey: String = "title",
        resourceName: ResourceNameResolver = LocalizedTutorial.resourceName,
        resourceKeySeparator: ResourceKeySeparator = ".",
        pageResolver: @escaping (TutorialId, PageIndex, ResourceNameResolver, ResourceKeySeparator) -> Page,
        translator: @escaping Translator = { NSLocalizedString($0, comment: "") }) {
        var index = 0
        var pages = [Page]()
        var titleKey = resourceName(id, index, pageIndicationKey, resourceKeySeparator)
        while titleKey != translator(titleKey) {
            let page = pageResolver(id, index, resourceName, resourceKeySeparator)
            pages.append(page)
            index += 1
            titleKey = resourceName(id, index, pageIndicationKey, resourceKeySeparator)
        }
        super.init(pages: pages)
    }
    
    public typealias PageIndex = Int
    public typealias ResourceKey = String
    public typealias ResourceKeySeparator = String
    public typealias ResourceName = String
    public typealias ResourceNameResolver = (TutorialId, PageIndex, ResourceKey, ResourceKeySeparator) -> ResourceName
    public typealias Translator = (String) -> String
    public typealias TutorialId = String
}

public extension LocalizedTutorial where Page == TutorialPage {
    
    /**
     Create a tutorial by automatically creating pages based
     on localized strings.
     
     This init uses `LocalizedTutorial.standardPage(...)` to
     create tutorial pages. It's just kept in this extension
     since the generic constraint is required.
     */
    convenience init(
        id: String,
        pageIndicationKey: String = "title",
        resourceName: ResourceNameResolver = LocalizedTutorial.resourceName,
        resourceKeySeparator: ResourceKeySeparator = ".",
        translator: @escaping Translator = { NSLocalizedString($0, comment: "") }) {
        self.init(
            id: id,
            pageIndicationKey: pageIndicationKey,
            resourceName: resourceName,
            resourceKeySeparator: resourceKeySeparator,
            pageResolver: LocalizedTutorial.page,
            translator: translator)
    }
}

public extension LocalizedTutorial {
    
    /**
     This function generates resource names using the format
     `tutorial.<id>.<index>.<key>`.
     */
    static func resourceName(
        for tutorialId: TutorialId,
        at pageIndex: PageIndex,
        resourceKey: ResourceKey,
        resourceKeySeparator: ResourceKeySeparator) -> ResourceName {
        let key = resourceKey.trimmingCharacters(in: .whitespaces)
        var segments = ["tutorial", tutorialId, "\(pageIndex)"]
        if key.count > 0 { segments.append(key) }
        return segments.joined(separator: resourceKeySeparator)
    }
    
    /**
     This function generates `TutorialPage`s by translating  using the format
     `tutorial.<id>.<index>.<key>`.
     */
    static func page(
        for tutorialId: TutorialId,
        at pageIndex: PageIndex,
        resourceName: ResourceNameResolver = LocalizedTutorial.resourceName,
        resourceKeySeparator: ResourceKeySeparator) -> TutorialPage {
        let separator = resourceKeySeparator
        let titleKey = resourceName(tutorialId, pageIndex, "title", separator)
        let title = NSLocalizedString(titleKey, comment: "")
        let textKey = resourceName(tutorialId, pageIndex, "text", separator)
        let text = NSLocalizedString(textKey, comment: "")
        let imageName = resourceName(tutorialId, pageIndex, "image", separator)
        return TutorialPage(title: title, text: text, imageName: imageName)
    }
}
