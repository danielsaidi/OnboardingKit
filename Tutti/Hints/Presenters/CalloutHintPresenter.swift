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

    open func present(hint: Hint, in vc: UIViewController, from view: UIView) {
        dismiss(hint: hint)
        createCallout(for: hint).show(forView: view)
        
    }
    
    open func present(hint: Hint, in vc: UIViewController, from item: UIBarButtonItem) {
        dismiss(hint: hint)
        createCallout(for: hint).show(forItem: item)
    }
    
    open func dismiss(hint: Hint) {
        let callouts = presentedCallouts.filter { $0.text == hint.text }
        callouts.forEach { $0.dismiss() }
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
