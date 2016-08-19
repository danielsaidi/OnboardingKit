//
//  Translate.swift
//  Tutti
//
//  Created by Daniel Saidi on 2015-04-15.
//  Copyright (c) 2015 Daniel Saidi. All rights reserved.
//

import Foundation

func translate(key: String) -> String {
    return NSLocalizedString(key, comment: "")
}

func translationExists(key: String) -> Bool {
    return translate(key) != key
}