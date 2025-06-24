//
//  LocalizedOnboarding.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2020-09-06.
//  Copyright © 2020-2025 Daniel Saidi. All rights reserved.
//

import Foundation

@available(*, deprecated, message: "This type is deprecated and will be removed in the next major release.")
open class LocalizedOnboarding {
    
    /// Create a localized onboarding.
    ///
    /// - Parameters:
    ///   - id: The id to use.
    ///   - bundle: The bundle to use, by default `main`.
    ///   - pageIndicationKey: The pageIndicationKey to use, by default `"title"`.
    ///   - resourceName: The resource name resolver to use, by default a standard one.
    ///   - resourceKeySeparator: The resourceKeySeparator to use, by default `"."`.
    ///   - pageResolver: The page resolver to use, by default a standard one.
    ///   - translator: The translator to use, if any.
    public init(
        id: String,
        bundle: Bundle = .main,
        pageIndicationKey: String = "title",
        resourceName: ResourceNameResolver = LocalizedOnboarding.resourceName,
        resourceKeySeparator: ResourceKeySeparator = ".",
        pageResolver: @escaping PageResolver = LocalizedOnboarding.page,
        translator: Translator? = nil
    ) {
        var index = 0
        var pages = [Page]()
        var titleKey = resourceName(id, index, pageIndicationKey, resourceKeySeparator)
        let translator = translator ?? { NSLocalizedString($0, bundle: bundle, comment: "") }
        while titleKey != translator(titleKey) {
            let page = pageResolver(id, index, bundle, resourceName, resourceKeySeparator)
            pages.append(page)
            index += 1
            titleKey = resourceName(id, index, pageIndicationKey, resourceKeySeparator)
        }
        self.pages = pages
    }
    
    /// This class represents a page in an onboarding flow.
    public class Page: Identifiable {
        
        public init(
            id: UUID = .init(),
            title: String,
            text: String,
            imageName: String? = nil
        ) {
            self.id = id
            self.title = title
            self.text = text
            self.imageName = imageName
        }
        
        /// The unique page ID.
        public let id: UUID
        
        /// The page title.
        public let title: String
        
        /// The page text.
        public let text: String
        
        /// The name of the image asset.
        public let imageName: String?
    }
    
    public let pages: [Page]
    
    public typealias PageIndex = Int
    public typealias PageResolver = (
        Onboarding.ID,
        PageIndex, Bundle,
        ResourceNameResolver,
        ResourceKeySeparator
    ) -> Page
    public typealias ResourceKey = String
    public typealias ResourceKeySeparator = String
    public typealias ResourceName = String
    public typealias ResourceNameResolver = (
        Onboarding.ID,
        PageIndex,
        ResourceKey,
        ResourceKeySeparator
    ) -> ResourceName
    public typealias Translator = (String) -> String

    /// This function generates resource names, by using the
    /// format `onboarding.<id>.<index>.<key>`.
    public static func resourceName(
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
    
    /// This function generates onboarding pages, by using a
    /// translator to translate `onboarding.<id>.<index>.<key>`.
    public static func page(
        for id: Onboarding.ID,
        at pageIndex: PageIndex,
        in bundle: Bundle,
        resourceName: ResourceNameResolver = LocalizedOnboarding.resourceName,
        resourceKeySeparator: ResourceKeySeparator
    ) -> Page {
        let separator = resourceKeySeparator
        let titleKey = resourceName(id, pageIndex, "title", separator)
        let title = NSLocalizedString(titleKey, bundle: bundle, comment: "")
        let textKey = resourceName(id, pageIndex, "text", separator)
        let text = NSLocalizedString(textKey, bundle: bundle, comment: "")
        let imageName = resourceName(id, pageIndex, "image", separator)
        return .init(title: title, text: text, imageName: imageName)
    }
}
