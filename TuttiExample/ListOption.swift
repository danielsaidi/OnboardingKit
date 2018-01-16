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
    tutorial,
    tutorial_l10n,
    tutorial_user(id: String)
}


// MARK: - Public Functions

extension ListOption {
    
    var title: String {
        switch self {
        case .hint: return "Show a quick hint"
        case .reset: return "Reset display state"
        case .spacer: return ""
        case .tutorial: return "Show a basic hint"
        case .tutorial_l10n: return "Show a localization-based tutorial"
        case .tutorial_user(let userId): return "Show a quick tutorial for user \(userId)"
        }
    }
}
