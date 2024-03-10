//
//  LocalizedOnboardingFlow.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2020-09-06.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This ``OnboardingFlow`` is automatically created by parsing
 pages based on localized strings.
 
 This gives you much flexibility, since it lets you manage a
 flow by just adjusting localized strings and images.
 
 The `pageResolver` starts at index 0 and checks if a string
 exists for certain keys. As long as a page exists, it keeps
 appending pages that are created by the resolver.
 
 If you don't provide a ``ResourceNameResolver`` it will use
 ``resourceName(for:at:key:keySeparator:)``, that uses a key
 format that makes the title at page 2 in an onboarding with
 the id `hello` get the key `onboarding.hello.2.title`.
 
 If you don't provide a `pageResolver` the flow will use the
 ``LocalizedOnboardingFlow/page(for:at:in:resourceName:resourceKeySeparator:)``
 that generates ``OnboardingPage`` values by translating
 `title` and `text` using the `resourceNameResolver`.
 */
open class LocalizedOnboardingFlow: OnboardingFlow {
    
    /**
     Create an onboarding flow by automatically generating a
     collection of pages from localized strings.
     */
    public init(
        id: String,
        bundle: Bundle = .main,
        pageIndicationKey: String = "title",
        resourceName: ResourceNameResolver = LocalizedOnboardingFlow.resourceName,
        resourceKeySeparator: ResourceKeySeparator = ".",
        pageResolver: @escaping PageResolver,
        translator: Translator? = nil
    ) {
        var index = 0
        var pages = [OnboardingPage]()
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
    public typealias PageResolver = (Onboarding.ID, PageIndex, Bundle, ResourceNameResolver, ResourceKeySeparator) -> OnboardingPage
    public typealias ResourceKey = String
    public typealias ResourceKeySeparator = String
    public typealias ResourceName = String
    public typealias ResourceNameResolver = (Onboarding.ID, PageIndex, ResourceKey, ResourceKeySeparator) -> ResourceName
    public typealias Translator = (String) -> String
}

public extension LocalizedOnboardingFlow {
    
    /**
     Create an onboarding flow by automatically generating a
     collection of pages from localized strings.
     */
    convenience init(
        id: String,
        bundle: Bundle = .main,
        pageIndicationKey: String = "title",
        resourceName: ResourceNameResolver = LocalizedOnboardingFlow.resourceName,
        resourceKeySeparator: ResourceKeySeparator = ".",
        translator: Translator? = nil
    ) {
        self.init(
            id: id,
            bundle: bundle,
            pageIndicationKey: pageIndicationKey,
            resourceName: resourceName,
            resourceKeySeparator: resourceKeySeparator,
            pageResolver: LocalizedOnboardingFlow.page,
            translator: translator
        )
    }
}

public extension LocalizedOnboardingFlow {
    
    /**
     This function generates resource names using the format
     `onboarding.<id>.<index>.<key>`.
     */
    static func resourceName(
        for id: Onboarding.ID,
        at pageIndex: PageIndex,
        key: ResourceKey,
        keySeparator: ResourceKeySeparator
    ) -> ResourceName {
        let key = key.trimmingCharacters(in: .whitespaces)
        var segments = ["onboarding", id, "\(pageIndex)"]
        if key.count > 0 { segments.append(key) }
        return segments.joined(separator: keySeparator)
    }
    
    /**
     This function generates pages by translating  using the
     format `onboarding.<id>.<index>.<key>`.
     */
    static func page(
        for id: Onboarding.ID,
        at pageIndex: PageIndex,
        in bundle: Bundle,
        resourceName: ResourceNameResolver = LocalizedOnboardingFlow.resourceName,
        resourceKeySeparator: ResourceKeySeparator
    ) -> OnboardingPage {
        let separator = resourceKeySeparator
        let titleKey = resourceName(id, pageIndex, "title", separator)
        let title = NSLocalizedString(titleKey, bundle: bundle, comment: "")
        let textKey = resourceName(id, pageIndex, "text", separator)
        let text = NSLocalizedString(textKey, bundle: bundle, comment: "")
        let imageName = resourceName(id, pageIndex, "image", separator)
        return .init(title: title, text: text, imageName: imageName)
    }
}
