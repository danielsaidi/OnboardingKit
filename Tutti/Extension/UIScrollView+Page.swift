//
//  UIScrollView+Page.swift
//  Tutti
//
//  Created by Daniel Saidi on 2017-12-10.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

import UIKit

extension UIScrollView {

    var currentPage: Int {
        let width = frame.size.width
        return Int((contentOffset.x + (0.5 * width)) / width)
    }
}
