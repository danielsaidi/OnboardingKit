//
//  CalloutHintPresenter.swift
//  Tutti
//
//  Created by Daniel Saidi on 2018-02-11.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

#if os(iOS)
import UIKit

/**
 This presenter displays hints using a bubble that points at
 to target view. For more information about how to customize
 the appearance of a callout view, checkout the `CalloutView`
 class documentation.
 */
open class CalloutHintPresenter: HintPresenter, CalloutViewDelegate {
    
    
    // MARK: - Initialization
    
    public init() {}
    
    
    // MARK: - Properties
    
    private var callouts = [CalloutView]()
    
    
    // MARK: - Public Functions
    
    open func dismiss(_ hint: Hint) {
        let views = callouts.filter { $0.text == hint.text }
        views.forEach { $0.dismiss() }
    }
    
    open func dismissAllHints() {
        callouts.forEach { $0.dismiss() }
    }

    open func present(
        _ hint: Hint,
        with onboarding: Onboarding,
        in vc: UIViewController,
        from view: UIView) {
        tryPresent(onboarding) {
            callout(for: hint).show(forView: view, withinSuperview: vc.view)
        }
    }
    
    open func present(
        _ hint: Hint,
        with onboarding: Onboarding,
        in vc: UIViewController,
        from item: UIBarButtonItem) {
        tryPresent(onboarding) {
            callout(for: hint).show(forItem: item, withinSuperView: vc.view)
        }
    }
    
    
    // MARK: - CalloutViewDelegate
    
    open func calloutViewDidDismiss(_ tipView: CalloutView) {
        callouts = callouts.filter { $0.text != tipView.text }
    }
}


// MARK: - Internal Functions

extension CalloutHintPresenter {
    
    func callout(for hint: Hint) -> CalloutView {
        let callout = CalloutView(text: hint.text, accessibilityText: hint.accessibilityText, preferences: CalloutView.globalPreferences, delegate: self)
        callouts.append(callout)
        return callout
    }
}
#endif
