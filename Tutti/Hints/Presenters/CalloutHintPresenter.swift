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
 
 This presenter uses `CalloutView`, which is a plain fork of
 the great `EasyTipView` GitHub repo. For more details about
 this library, checkout the `CalloutView` class.
 
 `EasyTipView` provides extensive appearance support. I have
 ported this as well, so you can use `globalPreferences` for
 styling these bubbles just as you would do with EasyTipView.
 Checkout https://github.com/teodorpatras/EasyTipView to see
 the various options you have, or checkout the demo app.
 
 */


import UIKit

public class CalloutHintPresenter: HintPresenter {
    
    
    // MARK: - Initialization
    
    public init() {}
    
    
    // MARK: - Public Functions

    public func present(hint: Hint, in vc: UIViewController, from view: UIView) -> Bool {
        if hint.hasBeenDisplayed { return false }
        hint.hasBeenDisplayed = true
        CalloutView.show(forView: view, text: hint.text)
        return true
    }
    
    public func dismiss(hint: Hint) { }
}
