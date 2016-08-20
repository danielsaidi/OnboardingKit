//
//  TutorialAnimation.swift
//  Tutti
//
//  Created by Daniel Saidi on 2016-08-15.
//  Copyright (c) 2016 Daniel Saidi. All rights reserved.
//
//

import UIKit

class TutorialAnimation: NSObject {
    
    public init(animation: () -> (), duration: CGFloat, options: UIViewAnimationOptions?) {
        self.animation = animation
        self.duration = duration
        self.options = options
    }

    public var animation: () -> ()
    public var duration: CGFloat
    public var options: UIViewAnimationOptions?
    
    
    public class func fadeInAnimation(view: UIView) -> () -> () {
        return { view.alpha = 1.0 }
    }
    
    public class func fadeOutAnimation(view: UIView) -> () -> () {
        return { view.alpha = 0.0 }
    }
    
    public class func slideDownAnimation(view: UIView) -> () -> () {
        return { view.frame = view.frameAbove }
    }
    
    public class func slideLeftAnimation(view: UIView) -> () -> () {
        return { view.frame = view.frameLeft }
    }
    
    public class func slideRightAnimation(view: UIView) -> () -> () {
        return { view.frame = view.frameRight }
    }
    
    public class func slideUpAnimation(view: UIView) -> () -> () {
        return { view.frame = view.frameAbove }
    }
}
