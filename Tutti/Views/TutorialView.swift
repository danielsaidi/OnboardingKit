//
//  TutorialView.swift
//  Tutti
//
//  Created by Daniel Saidi on 2017-12-08.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

/*
 
 This is a base class that defines one way to show tutorials
 with Tutti. Use it if you like, or build custom views.
 
 */

import UIKit

open class TutorialView: UIView {

    
    // MARK: - Outlets
    
    @IBOutlet open weak var imageView: UIImageView?
    @IBOutlet open weak var textView: UITextView?
    @IBOutlet open weak var titleLabel: UILabel?

    
    // MARK: - Public Functions
    
    open func refresh(with tutorial: Tutorial) {
        refresh(titleLabel: titleLabel, for: tutorial)
        refresh(textView: textView, for: tutorial)
        refresh(imageView: imageView, for: tutorial)
    }
    
    open func refresh(imageView: UIImageView?, for tutorial: Tutorial) {
        let imageName = tutorial.resourceName(for: "")
        let image = UIImage(named: imageName)
        imageView?.image = image
    }
    
    open func refresh(textView: UITextView?, for tutorial: Tutorial) {
        let key = tutorial.resourceName(for: "text")
        textView?.text = translate(key)
    }
    
    open func refresh(titleLabel: UILabel?, for tutorial: Tutorial) {
        let key = tutorial.resourceName(for: "title")
        titleLabel?.text = translate(key)
    }
}


// MARK: - Private Functions

fileprivate extension TutorialView {
    
    func translate(_ key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
}
