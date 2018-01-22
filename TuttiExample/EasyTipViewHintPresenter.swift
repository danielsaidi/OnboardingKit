//
//  EasyTipViewHintPresenter.swift
//  Tutti
//
//  Created by Daniel Saidi on 2018-01-22.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

/*
 
 This hint presenter can display hints with the `EasyTipView`
 Swift library (`https://github.com/teodorpatras/EasyTipView`).
 
 To use this hint presenter, you must first add `EasyTipView`
 to your app, with e.g. Carthage or CocoaPods. You must then
 uncomment the disabled lines below and remove the alert one.
 
 This presenter is not added to `Tutti`, since it requires a
 dependency to `EasyTipView`. Instead, if you want to use it,
 just copy this class to any app that uses `EasyTipView`.
 
 To enable this presenter in the `Tutti` demo app, just open
 the `Cartfile` and uncomment the commented out `EasyTipView`
 line, run `carthage update --platform ios` then finally add
 `EasyTipView` to the app. You should then be able to enable
 the disabled lines below and run the app.
 
 */

import UIKit
import Tutti
//import EasyTipView

public class EasyTipViewHintPresenter: HintPresenter {
    
    public func present(hint: Hint, in vc: UIViewController, from view: UIView) -> Bool {
        if hint.hasBeenDisplayed { return false }
        _ = AlertingHintPresenter().present(hint: hint, in: vc, from: view)
        hint.hasBeenDisplayed = true
        //EasyTipView.show(forView: view, text: hint.text)
        return true
    }
    
    public func dismiss(hint: Hint) { }
}
