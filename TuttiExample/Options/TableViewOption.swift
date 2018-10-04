//
//  TableViewOption.swift
//  TuttiExample
//
//  Created by Daniel Saidi on 2018-01-16.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import UIKit

enum TableViewOption {
    case
    hint,
    deferredHint,
    dismissCurrentHint,
    reset,
    tutorial,
    localizedTutorial,
    deferredTutorial
}


// MARK: - Public Functions

extension TableViewOption {
    
    var title: String {
        switch self {
        case .hint: return "Show a standard hint"
        case .deferredHint: return "Show a deferred hint"
        case .dismissCurrentHint: return "Dismiss current hint"
        
        case .tutorial: return "Show a standard tutorial"
        case .localizedTutorial: return "Show a localized tutorial"
        case .deferredTutorial: return "Show a deferred tutorial"
            
        case .reset: return "Reset display state"
        }
    }
    
    var description: String {
        switch self {
        case .hint: return "Hints are simple messages that are intended to be displayed once. They are perfect for quick, non-intrusive onboarding."
        case .deferredHint: return "Deferred hints are displayed after a custom number of presentation attempts. They are perfect for when you want to wait a while with displaying a hint."
        case .dismissCurrentHint: return "This will try to find a matching hint view and dismiss it from the screen. You should do this on viewWillDisappear(...)."
        
        case .tutorial: return "Tutorials are single or multi page guides that are intended to display more information than a quick hint. They are perfect for modal screens or multi page guides."
        case .localizedTutorial: return "Localized tutorials automatically generate themselved by using available language keys in the current app. This saves you a lot of time and hassle."
        case .deferredTutorial: return "Deferred tutorials are displayed after a custom number of presentation attempts. They are perfect for when you want to wait a while with displaying a tutorial."
            
        case .reset: return "Tell all hints and tutorials to mark themselves as not displayed, so they can be displayed again."
        }
    }
}
