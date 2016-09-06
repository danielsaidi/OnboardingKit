//
//  TutorialViewController.swift
//  Tutti
//
//  Created by Daniel Saidi on 2016-08-15.
//  Copyright (c) 2016 Daniel Saidi. All rights reserved.
//

import UIKit


public protocol TutorialViewControllerDelegate : class {
    func tutorialViewController(tutorial: TutorialViewController, didTriggerAction action: String)
    func tutorialViewControllerDidFinish(tutorial: TutorialViewController)
}


public enum TutorialViewControllerSwipeRightBehavior { case
    Next,
    Proceed
}



public class TutorialViewController: UIViewController {
    
    
    // MARK: View lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupAutoresizing()
        setupSwipeGestures()
    }
    
    public override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
    }
    
    
    
    // MARK: Setup
    
    private func setupAutoresizing() {
        view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight, .FlexibleTopMargin, .FlexibleBottomMargin, .FlexibleLeftMargin, .FlexibleRightMargin]
    }
    
    private func setupSwipeGestures() {
        if (swipeable) {
            setupSwipeGestureWithDirection(.Left)
            setupSwipeGestureWithDirection(.Right)
        }
    }
    
    private func setupSwipeGestureWithDirection(direction: UISwipeGestureRecognizerDirection) {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipe.direction = direction
        view.userInteractionEnabled = true
        view.addGestureRecognizer(swipe)
    }
    
    
    
    // MARK: Outlets
    
    @IBOutlet public weak var closeButton: UIButton!
    @IBOutlet public weak var containerView: UIView!
    @IBOutlet public weak var imageView: UIImageView!
    @IBOutlet public weak var nextButton: UIButton!
    @IBOutlet public weak var pageControl: UIPageControl!
    @IBOutlet public weak var previousButton: UIButton!
    @IBOutlet public weak var proceedButton: UIButton!
    @IBOutlet public weak var textView: UITextView!
    @IBOutlet public weak var titleLabel: UILabel!
    
    
    
    // MARK: Properties
    
    public weak var delegate: TutorialViewControllerDelegate?
    
    public var tutorial: Tutorial!
    public var swipeable = false
    public var swipeRightBehavior = TutorialViewControllerSwipeRightBehavior.Next
    
    
    
    // MARK: Actions
    
    @IBAction public func close(sender: AnyObject) {
        tutorial.hasBeenDisplayed = true
        animateClose { 
            self.view.removeFromSuperview()
            self.delegate?.tutorialViewControllerDidFinish(self)
        }
    }
    
    @IBAction public func next(sender: AnyObject) {
        if (tutorial.next()) {
            animateNext()
            refresh()
        }
    }
    
    @IBAction public func previous(sender: AnyObject) {
        if (tutorial.previous()) {
            animatePrevious()
            refresh()
        }
    }
    
    @IBAction public func proceed(sender: AnyObject) {
        tutorial.isLastPage ? close(sender) : next(sender)
    }
    
    
    
    // MARK: Public methods
    
    public func animateClose(completion: () -> ()) {
        let anim = { self.view.alpha = 0.0 }
        UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseOut, animations: anim) { finished in
            completion()
        }
    }
    
    public func animateNext() {
        animatePagination(true)
    }
    
    public func animatePrevious() {
        animatePagination(false)
    }
    
    public func animateShow() {
        self.view.alpha = 0.0
        let anim = { self.view.alpha = 1.0 }
        UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseOut, animations: anim) { finished in }
    }
    
    public func handleSwipe(swipe: UISwipeGestureRecognizer) {
        if (swipe.direction == .Left) {
            swipeRightBehavior == .Proceed ? proceed(swipe) : next(swipe)
        } else if (swipe.direction == .Right) {
            previous(swipe)
        }
    }
    
    public func refresh() {
        refreshImageView()
        refreshTitleLabel()
        refreshTextView()
        refreshButton(closeButton, withIdentifier: "close")
        refreshButton(previousButton, withIdentifier: "previous")
        refreshButton(nextButton, withIdentifier: "next")
        refreshButton(proceedButton, withIdentifier: "proceed")
        previousButton?.hidden = tutorial!.isFirstPage
        nextButton?.hidden = tutorial!.isLastPage
        proceedButton?.hidden = !tutorial!.isLastPage
        refreshPageControl()
    }
    
    public func refreshButton(button: UIButton!, withIdentifier identifier: String) {
        let key = tutorial!.getResourceName(identifier)
        if (translationExists(key)) {
            button?.setTitle(translate(key), forState: .Normal)
        }
    }
    
    public func refreshImageView() {
        let key = tutorial!.getResourceName("")
        print(key)
        let image = UIImage(named: key)
        imageView?.image = image
    }
    
    public func refreshPageControl() {
        pageControl?.hidden = tutorial.pageCount < 2;
        pageControl?.currentPage = tutorial.currentPageIndex
        pageControl?.numberOfPages = tutorial.pageCount
    }
    
    public func refreshTextView() {
        let key = tutorial.getResourceName("text")
        if (translationExists(key)) {
            textView?.text = translate(key)
        }
    }
    
    public func refreshTitleLabel() {
        let key = tutorial.getResourceName("title")
        if (translationExists(key)) {
            titleLabel?.text = translate(key)
        }
    }
    
    public func showTutorial(tutorial: Tutorial, inView view: UIView) -> Bool {
        if (tutorial.hasBeenDisplayed) {
            delegate?.tutorialViewControllerDidFinish(self)
            return false
        }
        
        self.tutorial = tutorial
        view.addSubview(self.view)
        refresh()
        animateShow()
        return true
    }
    
    
    
    // MARK: Private functions
    
    public func animatePagination(next: Bool) {
        let animation = CATransition()
        animation.duration = 0.5
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = kCATransitionPush
        animation.subtype = next ? kCATransitionFromRight : kCATransitionFromLeft
        containerView.layer.addAnimation(animation, forKey: nil)
    }
}
