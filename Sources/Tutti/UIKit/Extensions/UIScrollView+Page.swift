//
//  UIScrollView+Page.swift
//  Tutti
//
//  Created by Daniel Saidi on 2017-12-10.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import UIKit

extension UIScrollView {

    /**
     Get the current page index of a paged scroll view.
     
     This function uses the scroll view `contentOffset.x` to
     calculate the current page index.
     */
    var pageIndex: Int {
        let width = frame.size.width
        let offset = contentOffset.x
        return Int((offset + (0.5 * width)) / width)
    }
    
    /**
     Set the current page index of a paged scroll view.
     */
    func setPageIndex(_ index: Int, animated: Bool) {
        let width = frame.size.width
        let point = CGPoint(x: CGFloat(index) * width, y: 0)
        setContentOffset(point, animated: animated)
    }
}
#endif
