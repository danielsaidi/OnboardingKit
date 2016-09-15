//
//  UIView_Fade.swift
//  Tutti
//
//  Created by Daniel Saidi on 2016-01-14.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

import UIKit

public extension UIView {
    
    public func fadeInWithDuration(_ duration: TimeInterval) {
        alpha = 0
        let animations = { self.alpha = 1 }
        UIView.animate(withDuration: duration, delay: 0, options: UIViewAnimationOptions(), animations: animations) {
            completed in
        }
    }
    
    public func fadeOutWithDuration(_ duration: TimeInterval) {
        let animations = { self.alpha = 0 }
        UIView.animate(withDuration: duration, delay: 0, options: UIViewAnimationOptions(), animations: animations) {
            completed in
        }
    }
}
