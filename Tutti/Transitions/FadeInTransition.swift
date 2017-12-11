//
//  FadeInTransition.swift
//  Tutti
//
//  Created by Daniel Saidi on 2017-12-11.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

import UIKit

open class FadeInTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    
    // MARK: - Initialization
    
    public init(fadeDuration: Double = 0.35) {
        self.duration = fadeDuration
    }
    
    
    // MARK: - Properties
    
    var duration = 0.35
    var isPresenting = true
    
    
    // MARK: - Public Functions
    
    open func transitionDuration(using context: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    open func animateTransition(using context: UIViewControllerContextTransitioning) {
        guard
            let fromView = context.view(forKey: .from),
            let toView = context.view(forKey: .to),
            let toVc = context.viewController(forKey: .to)
            else { return }
        
        let containerView = context.containerView
        toVc.modalPresentationStyle = .overCurrentContext
        
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
            completion: { completed in
                context.completeTransition(true)
                containerView.insertSubview(fromView, belowSubview: toView)
            }
        )
    }
}
