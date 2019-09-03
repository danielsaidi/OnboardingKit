//
//  UIScrollView+Page.swift
//  Tutti
//
//  Created by Daniel Saidi on 2017-12-10.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

import UIKit

extension UIScrollView {

    /**
     Get the current page of a paged scroll view.
     
     This function uses the scroll view's content offset to
     calculate the "current page".
     */
    var pageIndex: Int {
        let width = frame.size.width
        return Int((contentOffset.x + (0.5 * width)) / width)
    }
    
    /**
     Set the current page of a paged scroll view.
     
     This function uses the scroll view's content offset to
     set the new "current page".
     */
    func setPageIndex(_ index: Int, animated: Bool) {
        let width = frame.size.width
        let point = CGPoint(x: CGFloat(index) * width, y: 0)
        setContentOffset(point, animated: animated)
    }
}
