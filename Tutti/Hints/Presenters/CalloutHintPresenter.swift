//
//  CalloutHintPresenter.swift
//  Tutti
//
//  Created by Daniel Saidi on 2018-02-11.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

/*
 
 This presenter displays hints using a bubble that points at
 to target view.
 
 This presenter uses a fork of the superb `EasyTipView` repo.
 For more details about, checkout the `CalloutView` class.
 
 */


import UIKit

public class CalloutHintPresenter: HintPresenter {
    
    
    // MARK: - Initialization
    
    public init() {}
    
    
    // MARK: - Public Functions

    public func present(hint: Hint, in vc: UIViewController, from view: UIView) {
        CalloutView.show(forView: view, text: hint.text)
    }
    
    public func dismiss(hint: Hint) { }
}
