//
//  ViewController+Appearance.swift
//  TuttiExample
//
//  Created by Daniel Saidi on 2018-02-11.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import UIKit
import Tutti

extension ViewController {
    
    func applyAppearance() {
        var preferences = CalloutView.globalPreferences
        let green = UIColor(red: 11/255, green: 102/255, blue: 35/255, alpha: 1)
        preferences.drawing.backgroundColor = green
        CalloutView.globalPreferences = preferences
    }
}
