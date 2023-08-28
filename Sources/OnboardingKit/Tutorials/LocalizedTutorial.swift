//
//  LocalizedTutorial.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2020-09-06.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 A `LocalizedTutorial` is created by automatically resolving
 pages based on localized strings.
 
 This gives you much flexibility, since it lets you manage a
 tutorial by just adjusting localized strings and images.
 
 The `pageResolver` starts at index 0 and checks if a string
 exists for a key that is made up by the provided parameters.
 As long as a page does exist, it keeps appending pages that
 are created by the `pageResolver`.
 
 If you don't provide a custom `ResourceNameResolver`, `init`
 applies a static `LocalizedTutorial.resourceName(...)` that
 generates a resource name by starting with `tutorial`, then
 applying `id`, `page index` and a `resource key` then joins
 them using a `resourceKeySeparator` which by default is `.`.
 
 This will by deafult generate resource keys with the format
 `tutorial.<id>.<index>.<key>`. This means that the title at
 page 2 for a tutorial with the id `hello` gets the resource
 name `tutorial.hello.2.title` by default.
 
 If you don't provide a `pageResolver` `init` will apply the
 static `LocalizedTutorial.page(...)` which creates standard
 `TutorialPage`s by translating `title` and `text` given the
 `resourceNameResolver`. It also applies the "resource name"
 for `image` as `imageName` for each page.
 */
open class LocalizedTutorial: Tutorial<TutorialPage> {
    
    /**
     Create a tutorial by automatically creating pages based
     on localized strings.
     
     `translator` is just used for testing purposes although
     you can use it to provide custom translation mechanisms.
     */
    public init(
        id: String,
        bundle: Bundle = .main,
        pageIndicationKey: String = "title",
        resourceName: ResourceNameResolver = LocalizedTutorial.resourceName,
        resourceKeySeparator: ResourceKeySeparator = ".",
        pageResolver: @escaping PageResolver,
        translator: Translator?
    ) {
        var index = 0
        var pages = [TutorialPage]()
        var titleKey = resourceName(id, index, pageIndicationKey, resourceKeySeparator)
        let translator = translator ?? { NSLocalizedString($0, bundle: bundle, comment: "") }
        while titleKey != translator(titleKey) {
            let page = pageResolver(id, index, bundle, resourceName, resourceKeySeparator)
            pages.append(page)
            index += 1
            titleKey = resourceName(id, index, pageIndicationKey, resourceKeySeparator)
        }
        super.init(pages: pages)
    }
    
    public typealias PageIndex = Int
    public typealias PageResolver = (TutorialId, PageIndex, Bundle, ResourceNameResolver, ResourceKeySeparator) -> TutorialPage
    public typealias ResourceKey = String
    public typealias ResourceKeySeparator = String
    public typealias ResourceName = String
    public typealias ResourceNameResolver = (TutorialId, PageIndex, ResourceKey, ResourceKeySeparator) -> ResourceName
    public typealias Translator = (String) -> String
    public typealias TutorialId = String
}

public extension LocalizedTutorial {
    
    /**
     Create a tutorial by automatically creating pages based
     on localized strings.
     
     This init uses `LocalizedTutorial.standardPage(...)` to
     create tutorial pages.
     */
    convenience init(
        id: String,
        bundle: Bundle = .main,
        pageIndicationKey: String = "title",
        resourceName: ResourceNameResolver = LocalizedTutorial.resourceName,
        resourceKeySeparator: ResourceKeySeparator = ".",
        translator: Translator? = nil
    ) {
        self.init(
            id: id,
            bundle: bundle,
            pageIndicationKey: pageIndicationKey,
            resourceName: resourceName,
            resourceKeySeparator: resourceKeySeparator,
            pageResolver: LocalizedTutorial.page,
            translator: translator
        )
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
        resourceKeySeparator: ResourceKeySeparator
    ) -> ResourceName {
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
        in bundle: Bundle,
        resourceName: ResourceNameResolver = LocalizedTutorial.resourceName,
        resourceKeySeparator: ResourceKeySeparator
    ) -> TutorialPage {
        let separator = resourceKeySeparator
        let titleKey = resourceName(tutorialId, pageIndex, "title", separator)
        let title = NSLocalizedString(titleKey, bundle: bundle, comment: "")
        let textKey = resourceName(tutorialId, pageIndex, "text", separator)
        let text = NSLocalizedString(textKey, bundle: bundle, comment: "")
        let imageName = resourceName(tutorialId, pageIndex, "image", separator)
        return TutorialPage(title: title, text: text, imageName: imageName)
    }
}
