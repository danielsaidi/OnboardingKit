//
//  UIScrollView+Page.swift
//  Tutti
//
//  Created by Daniel Saidi on 2017-12-10.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

import UIKit

extension UIScrollView {

    var pageIndex: Int {
        let width = frame.size.width
        return Int((contentOffset.x + (0.5 * width)) / width)
    }
    
    func setPageIndex(_ index: Int, animated: Bool) {
        let width = frame.size.width
        let point = CGPoint(x: CGFloat(index) * width, y: 0)
        setContentOffset(point, animated: animated)
    }
}
