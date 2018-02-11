//
//  CalloutViewHintPresenter.swift
//  Tutti
//
//  Created by Daniel Saidi on 2018-01-22.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

/*
 
 This hint presenter can display hints with the `CalloutView`
 Swift library (`https://github.com/teodorpatras/CalloutView`).
 
 To use this hint presenter, you must first add `CalloutView`
 to your app, with e.g. Carthage or CocoaPods. You must then
 uncomment the disabled lines below and remove the alert one.
 
 This presenter is not added to `Tutti`, since it requires a
 dependency to `CalloutView`. Instead, if you want to use it,
 just copy this class to any app that uses `CalloutView`.
 
 To enable this presenter in the `Tutti` demo app, just open
 the `Cartfile` and uncomment the commented out `CalloutView`
 line, run `carthage update --platform ios` then finally add
 `CalloutView` to the app. You should then be able to enable
 the disabled lines below and run the app.
 
 */

import UIKit
import Tutti
//import CalloutView

public class CalloutViewHintPresenter: HintPresenter {
    
    public func present(hint: Hint, in vc: UIViewController, from view: UIView) -> Bool {
        if hint.hasBeenDisplayed { return false }
        _ = AlertingHintPresenter().present(hint: hint, in: vc, from: view)
        hint.hasBeenDisplayed = true
        //CalloutView.show(forView: view, text: hint.text)
        return true
    }
    
    public func dismiss(hint: Hint) { }
}
