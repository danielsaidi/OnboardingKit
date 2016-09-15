//
//  UIView_Frame.swift
//  Tutti
//
//  Created by Daniel Saidi on 2015-04-17.
//  Copyright (c) 2015 Daniel Saidi. All rights reserved.
//

import UIKit

public extension UIView {
    
    public var frameAbove: CGRect {
        get {
            let size = frame.size
            let origin = frame.origin
            return CGRect(x: origin.x, y: origin.y - size.height, width: size.width, height: size.height)
        }
    }
    
    public var frameBelow: CGRect {
        get {
            let size = frame.size
            let origin = frame.origin
            return CGRect(x: origin.x, y: origin.y + size.height, width: size.width, height: size.height)
        }
    }
    
    public var frameLeft: CGRect {
        get {
            let size = frame.size
            let origin = frame.origin
            return CGRect(x: origin.x - size.width, y: origin.y, width: size.width, height: size.height)
        }
    }
    
    public var frameRight: CGRect {
        get {
            let size = frame.size
            let origin = frame.origin
            return CGRect(x: origin.x + size.width, y: origin.y, width: size.width, height: size.height)
        }
    }
}
