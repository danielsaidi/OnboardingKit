//
//  CalloutHintPresenter.swift
//  Tutti
//
//  Created by Daniel Saidi on 2018-02-11.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

/*
 
 This presenter displays hints using a bubble that points at
 to target view. For more information about how to customize
 the appearance of a callout view, checkout the `CalloutView`
 class documentation.
 
 */


import UIKit

public class CalloutHintPresenter: HintPresenter, CalloutViewDelegate {
    
    
    // MARK: - Initialization
    
    public init() {}
    
    
    // MARK: - Properties
    
    private var presentedCallouts = [CalloutView]()
    
    
    // MARK: - Public Functions
    
    open func dismiss(_ hint: Hint) {
        let callouts = presentedCallouts.filter { $0.text == hint.text }
        callouts.forEach { $0.dismiss() }
    }
    
    open func dismissAllHints() {
        presentedCallouts.forEach { $0.dismiss() }
    }

    open func present(_ hint: Hint, in vc: UIViewController, from view: UIView) {
        tryPresent(hint) {
            createCallout(for: hint).show(forView: view, withinSuperview: vc.view)
        }
    }
    
    open func present(_ hint: Hint, in vc: UIViewController, from item: UIBarButtonItem) {
        tryPresent(hint) {
            createCallout(for: hint).show(forItem: item, withinSuperView: vc.view)
        }
    }
    
    
    // MARK: - CalloutViewDelegate
    
    open func calloutViewDidDismiss(_ tipView: CalloutView) {
        presentedCallouts = presentedCallouts.filter { $0.text != tipView.text }
    }
}


// MARK: - Internal Functions

extension CalloutHintPresenter {
    
    func createCallout(for hint: Hint) -> CalloutView {
        let callout = CalloutView(text: hint.text, preferences: CalloutView.globalPreferences, delegate: self)
        presentedCallouts.append(callout)
        return callout
    }
}
