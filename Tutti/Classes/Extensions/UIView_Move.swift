//
//  UIView_Move.swift
//  Tutti
//
//  Created by Daniel Saidi on 2015-04-17.
//  Copyright (c) 2015 Daniel Saidi. All rights reserved.
//

import UIKit

public extension UIView {
    
    public func moveToCenter(center: CGPoint, withDuration duration: Double, options: UIViewAnimationOptions, completion:((Bool) -> Void)?) {
        let anim = { self.center = center }
        UIView.animateWithDuration(duration, delay: 0, options: options, animations: anim, completion: completion)
    }
    
    public func moveToFrame(frame: CGRect, withDuration duration: Double, options: UIViewAnimationOptions, completion:((Bool) -> Void)?) {
        let anim = { self.frame = frame }
        UIView.animateWithDuration(duration, delay: 0, options: options, animations: anim, completion: completion)
    }
}
