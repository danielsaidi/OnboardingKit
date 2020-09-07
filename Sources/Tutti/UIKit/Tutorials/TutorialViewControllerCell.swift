//
//  TutorialViewControllerCell.swift
//  Tutti
//
//  Created by Daniel Saidi on 2017-12-08.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

#if os(iOS)
import UIKit

/**
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
open class TutorialViewControllerCell: UICollectionViewCell {

    @IBOutlet open weak var imageView: UIImageView?
    @IBOutlet open weak var textView: UITextView?
    @IBOutlet open weak var titleLabel: UILabel?

    open func update<Page: TutorialPage>(with page: Page) {
        titleLabel?.text = page.title
        textView?.text = page.text
        imageView?.image = UIImage(named: page.imageName ?? "")
    }
}
#endif
