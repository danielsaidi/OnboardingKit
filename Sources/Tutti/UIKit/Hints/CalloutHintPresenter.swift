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
 
 The presenter can be configured to present titles. If so, a
 hint that has any content in its title will be presented as
 a stack view instead of a plain text. When the presenter is
 configured to show titles, you should provide the types you
 want to use for the title and text labels. You can then use
 appearance proxies to style these labels. The `preferences`
 `font` property will not be applied to the stack view.
 */
open class CalloutHintPresenter: HintPresenter, CalloutViewDelegate {
    
    
    // MARK: - Initialization
    
    public init() {}
    
    
    // MARK: - Properties
    
    private var callouts = [CalloutView]()
    
    
    // MARK: - Public Functions
    
    open func dismiss(_ hint: Hint) {
        let views = callouts.filter { $0.isCallout(for: hint) }
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
            let callout = self.callout(for: hint)
            callout.show(forView: view, withinSuperview: vc.view)
        }
    }
    
    open func present(
        _ hint: Hint,
        with onboarding: Onboarding,
        in vc: UIViewController,
        from item: UIBarButtonItem) {
        tryPresent(onboarding) {
            let callout = self.callout(for: hint)
            callout.show(forItem: item, withinSuperView: vc.view)
        }
    }
    
    
    // MARK: - CalloutViewDelegate
    
    open func calloutViewDidDismiss(_ view: CalloutView) {
        callouts = callouts.filter { $0 != view }
    }
}


// MARK: - Internal Functions

extension CalloutHintPresenter {
    
    func callout(for hint: Hint) -> CalloutView {
        let callout = calloutView(for: hint)
        callout.accessibilityText = hint.accessibilityText
        callouts.append(callout)
        return callout
    }
    
    func calloutView(for hint: Hint) -> CalloutView {
        switch hint.hasTitle {
        case true: return CalloutView(hint: hint, preferences: CalloutView.globalPreferences, delegate: self)
        case false: return CalloutView(text: hint.text, preferences: CalloutView.globalPreferences, delegate: self)
        }
    }
}
#endif
