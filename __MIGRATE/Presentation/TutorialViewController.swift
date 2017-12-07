//
//  TutorialViewController.swift
//  Tutti
//
//  Created by Daniel Saidi on 2016-08-15.
//  Copyright (c) 2016 Daniel Saidi. All rights reserved.
//

/*
 
 This class that can be used to display tutorials. It is
 a very basic one with little customization options, but
 it will get you up and running quickly.
 
 The difference between next and proceed is that proceed
 will move next until the last page, then close the view
 controller, while next will do nothing if called on the
 last page.
 
 */

import UIKit


public enum TutorialViewControllerSwipeRightBehavior { case
    next,
    proceed
}


open class TutorialViewController: UIViewController, TutorialPresenter {
    
    
    // MARK: View Controller Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
    }
    
    
    
    
    // MARK: Properties
    
    open weak var delegate: TutorialPresenterDelegate?
    
    open var isSwipeable = true
    open var swipeRightBehavior = TutorialViewControllerSwipeRightBehavior.next
    
    fileprivate var tutorial: Tutorial?
    
    
    
    // MARK: Actions
    
    @IBAction open func close(_ sender: AnyObject) {
        guard let tutorial = tutorial else { return }
        tutorial.hasBeenDisplayed = true
        animateClose { 
            self.view.removeFromSuperview()
            self.delegate?.tutorialDidFinish(tutorial)
        }
    }
    
    @IBAction open func next(_ sender: AnyObject) {
        guard let tutorial = tutorial else { return }
        guard tutorial.next() else { return }
        animateNext()
        refresh()
    }
    
    @IBAction open func previous(_ sender: AnyObject) {
        guard let tutorial = tutorial else { return }
        guard tutorial.previous() else { return }
        animatePrevious()
        refresh()
    }
    
    @IBAction open func proceed(_ sender: AnyObject) {
        guard let tutorial = tutorial else { return }
        tutorial.isLastPage ? close(sender) : next(sender)
    }
    
    
    
    // MARK: Public methods
    
    open func animateClose(completion: @escaping () -> ()) {
        let anim = { self.view.alpha = 0.0 }
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: anim) { finished in
            completion()
        }
    }
    
    open func animateNext() {
        animatePagination(next: true)
    }
    
    open func animatePagination(next: Bool) {
        let animation = CATransition()
        animation.duration = 0.5
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = kCATransitionPush
        animation.subtype = next ? kCATransitionFromRight : kCATransitionFromLeft
        containerView?.layer.add(animation, forKey: nil)
    }
    
    open func animatePrevious() {
        animatePagination(next: false)
    }
    
    open func animateShow() {
        self.view.alpha = 0.0
        let anim = { self.view.alpha = 1.0 }
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: anim) { finished in }
    }
    
    @objc open func handleSwipe(_ swipe: UISwipeGestureRecognizer) {
        if (swipe.direction == .left) {
            swipeRightBehavior == .proceed ? proceed(swipe) : next(swipe)
        } else if (swipe.direction == .right) {
            previous(swipe)
        }
    }
    
    open func present(tutorial: Tutorial, in view: UIView) -> Bool {
        if (tutorial.hasBeenDisplayed) {
            self.delegate?.tutorialDidFinish(tutorial)
            return false
        }
        
        self.tutorial = tutorial
        self.view.frame = view.bounds
        view.addSubview(self.view)
        refresh()
        animateShow()
        return true
    }
    
    
}



// MARK: - Setup

fileprivate extension TutorialViewController {
    
    func setup() {
        setupAutoresizing()
        setupSwipeGestures()
    }
    
    func setupAutoresizing() {
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleTopMargin, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin]
    }
    
    func setupSwipeGestures() {
        guard isSwipeable else { return }
        setupSwipeGesture(withDirection: .left)
        setupSwipeGesture(withDirection: .right)
    }
    
    func setupSwipeGesture(withDirection direction: UISwipeGestureRecognizerDirection) {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipe.direction = direction
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(swipe)
    }
}
