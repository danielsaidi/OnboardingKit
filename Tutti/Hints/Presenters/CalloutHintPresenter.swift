//
//  CalloutHintPresenter.swift
//  Tutti
//
//  Created by Daniel Saidi on 2018-02-11.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

/*
 
 This presenter displays hints using a speech bubble that is
 pointing at the target view.
 
 The `BubbleView` class is a fork of the great `EasyTipView`
 GitHub repo. I had to fork it, since I could not find a way
 for the demo app to have more dependencies than the library.
 
 The `BubbleView` class comes with all the bells and whisles
 from `CalloutView`, for instance its great appearance setup.
 For more info on how style `BubbleView`, just check out the
 readme at https://github.com/teodorpatras/CalloutView.
 
 */


import UIKit

public class CalloutHintPresenter: UIImageView {

    public func present(hint: Hint, in vc: UIViewController, from view: UIView) -> Bool {
        if hint.hasBeenDisplayed { return false }
        hint.hasBeenDisplayed = true
        CalloutView.show(forView: view, text: hint.text)
        return true
    }
    
    public func dismiss(hint: Hint) { }
}
