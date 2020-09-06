//
//  TutorialTransition.swift
//  Tutti
//
//  Created by Daniel Saidi on 2018-01-18.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import UIKit

/**
 The protocol extends `UIViewControllerAnimatedTransitioning`
 and can be implemented by transitions that can be used when
 presenting tutorials.
 */
public protocol TutorialTransition: UIViewControllerAnimatedTransitioning {

    var isPresenting: Bool { get set }
}
#endif
