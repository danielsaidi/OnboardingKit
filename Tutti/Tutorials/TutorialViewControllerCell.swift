//
//  TutorialViewControllerCell.swift
//  Tutti
//
//  Created by Daniel Saidi on 2017-12-08.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

/*
 
 This is a collection view cell base class, that can be used
 to display a tutorial page in a `TutorialViewController`.
 
 If the view controller `collectionView` outlet is set, this
 cell will be dequeued for each page in the tutorial. Simply
 add a `TutorialPageCell` xib to your app and tell it to use
 this class, then connect the outlets you want to use.
 
 If you want to subclass this class (to be able to show more
 information), just create a custom class that inherits this
 class (together with a xib), then set the view controller's
 `cellType` property to your custom class type.
 
 */

import UIKit

open class TutorialViewControllerCell: UICollectionViewCell {

    
    // MARK: - Outlets
    
    @IBOutlet open weak var imageView: UIImageView?
    @IBOutlet open weak var textView: UITextView?
    @IBOutlet open weak var titleLabel: UILabel?

    
    // MARK: - Public Functions
    
    open func update(with tutorial: Tutorial) {
        update(titleLabel: titleLabel, for: tutorial)
        update(textView: textView, for: tutorial)
        update(imageView: imageView, for: tutorial)
    }
    
    open func update(imageView: UIImageView?, for tutorial: Tutorial) {
        let imageName = tutorial.resourceName(for: "")
        let image = UIImage(named: imageName)
        imageView?.image = image
    }
    
    open func update(textView: UITextView?, for tutorial: Tutorial) {
        let key = tutorial.resourceName(for: "text")
        textView?.text = NSLocalizedString(key, comment: "")
    }
    
    open func update(titleLabel: UILabel?, for tutorial: Tutorial) {
        let key = tutorial.resourceName(for: "title")
        titleLabel?.text = NSLocalizedString(key, comment: "")
    }
}
