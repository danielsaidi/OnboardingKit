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

public class CalloutHintPresenter: HintPresenter {
    
    
    // MARK: - Initialization
    
    public init() {}
    
    
    // MARK: - Public Functions

    public func present(hint: Hint, in vc: UIViewController, from view: UIView) {
        CalloutView.show(forView: view, text: hint.text)
    }
    
    public func dismiss(hint: Hint) { }
}
