//
//  UIView_Move.swift
//  Tutti
//
//  Created by Daniel Saidi on 2015-04-17.
//  Copyright (c) 2015 Daniel Saidi. All rights reserved.
//

import UIKit

public extension UIView {
    
    public func moveToCenter(_ center: CGPoint, withDuration duration: Double, options: UIViewAnimationOptions, completion:((Bool) -> Void)?) {
        let anim = { self.center = center }
        UIView.animate(withDuration: duration, delay: 0, options: options, animations: anim, completion: completion)
    }
    
    public func moveToFrame(_ frame: CGRect, withDuration duration: Double, options: UIViewAnimationOptions, completion:((Bool) -> Void)?) {
        let anim = { self.frame = frame }
        UIView.animate(withDuration: duration, delay: 0, options: options, animations: anim, completion: completion)
    }
}
