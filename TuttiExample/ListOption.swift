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
    hint(userId: String?),
    reset,
    tutorial(userId: String?),
    localizedTutorial(userId: String?)
}


// MARK: - Public Functions

extension ListOption {
    
    var title: String {
        switch self {
        case .hint: return "Show hint\(userSuffix)"
        case .reset: return "Reset display memory"
        case .tutorial: return "Show tutorial\(userSuffix)"
        case .localizedTutorial: return "Show localized tutorial\(userSuffix)"
        }
    }
    
    var userSuffix: String {
        switch self {
        case .hint(let userId): return userSuffix(for: userId)
        case .tutorial(let userId): return userSuffix(for: userId)
        case .localizedTutorial(let userId): return userSuffix(for: userId)
        default: return ""
        }
    }
}


// MARK: - Private Functions

fileprivate extension ListOption {
    
    func userSuffix(for userId: String?) -> String {
        return userId == nil ? "" : " for \"\(userId ?? "")\""
    }
}
