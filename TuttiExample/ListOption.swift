//
//  ListOption.swift
//  TuttiExample
//
//  Created by Daniel Saidi on 2018-01-16.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import UIKit

enum ListOption {
    case
    hint,
    reset,
    spacer,
    tutorial(userId: String?),
    tutorial_l10n(userId: String?)
}


// MARK: - Public Functions

extension ListOption {
    
    var title: String {
        switch self {
        case .hint: return "Show a quick hint"
        case .reset: return "Reset display state"
        case .spacer: return ""
        case .tutorial(_): return "Show a quick tutorial\(userSuffix)"
        case .tutorial_l10n(_): return "Show a localized tutorial\(userSuffix)"
        }
    }
    
    var userSuffix: String {
        switch self {
        case .tutorial(let userId): return userId == nil ? "" : "for user \(userId ?? "")"
        case .tutorial_l10n(let userId): return userId == nil ? "" : "for user \(userId ?? "")"
        default: return ""
        }
    }
}
