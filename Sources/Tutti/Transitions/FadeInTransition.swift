//
//  FadeInTransition.swift
//  Tutti
//
//  Created by Daniel Saidi on 2017-12-11.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This transition can be used to fade in a tutorial.
 */
open class FadeInTransition: NSObject, TutorialTransition {
    
    
    // MARK: - Initialization
    
    public init(fadeDuration: Double = 0.35) {
        super.init()
        self.duration = fadeDuration
    }
    
    
    // MARK: - Properties
    
    public var duration = 0.35
    public var isPresenting = true
    
    
    // MARK: - Public Functions
    
    open func animateTransition(using context: UIViewControllerContextTransitioning) {
        guard
            let fromView = context.view(forKey: .from),
            let toView = context.view(forKey: .to)
            else { return }
        
        let containerView = context.containerView
        if isPresenting {
            containerView.addSubview(toView)
        }
        
        let fadeView = isPresenting ? toView : fromView
        let finalAlpha = isPresenting ? fadeView.alpha : 0
        fadeView.alpha = isPresenting ? 0 : fadeView.alpha
        fadeView.frame = fromView.frame
        
        UIView.animate(
            withDuration: duration,
            animations: { fadeView.alpha = finalAlpha },
            completion: { _ in
                context.completeTransition(true)
                containerView.insertSubview(fromView, belowSubview: toView)
            }
        )
    }
    
    open func transitionDuration(using context: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
}
