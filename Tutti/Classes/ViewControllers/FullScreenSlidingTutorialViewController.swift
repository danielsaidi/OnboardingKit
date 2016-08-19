//
//  FullScreenSlidingTutorialViewController.swift
//  Tutti
//
//  Created by Daniel Saidi on 2015-04-16.
//  Copyright (c) 2015 Daniel Saidi. All rights reserved.
//

import UIKit
import QuartzCore

public class FullScreenSlidingTutorialViewController: TutorialViewController {
    
    
    // MARK: View controller lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupAutoresizing()
        setupSwipeGestures()
        containerView?.layer.masksToBounds = false
    }
    
    public override func viewWillAppear(animated: Bool) {
        refreshUserInterface()
    }
    
    
    
    // MARK: Setup
    
    private func setupAutoresizing() {
        view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight, .FlexibleTopMargin, .FlexibleBottomMargin, .FlexibleLeftMargin, .FlexibleRightMargin]
    }
    
    private func setupSwipeGestures() {
        setupSwipeGestureWithDirection(.Left)
        setupSwipeGestureWithDirection(.Right)
    }
    
    private func setupSwipeGestureWithDirection(direction: UISwipeGestureRecognizerDirection) {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(swipe(_:)))
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
    
    public var slideDuration = 0.25
    public var swipeDuration = 0.5
    
    
    
    // MARK: Actions
    
    public override func close(sender: AnyObject) {
        let anim = { self.view.frame = self.view.frameBelow }
        UIView.animateWithDuration(slideDuration, delay: 0, options: .CurveEaseOut, animations: anim) { (Bool) -> Void in
            super.close(sender)
        }
    }
    
    public override func next(sender: AnyObject) {
        if (!tutorial.isLastPage) {
            animateSubviewsGoingNext(true)
            super.next(sender)
        }
    }
    
    public override func previous(sender: AnyObject) {
        if (!tutorial.isFirstPage) {
            animateSubviewsGoingNext(false)
            super.previous(sender)
        }
    }
    
    public func swipe(swipe: UISwipeGestureRecognizer) {
        if (swipe.direction == .Left) {
            proceed(swipe)
        } else if (swipe.direction == .Right) {
            previous(swipe)
        }
    }
    
    
    
    // MARK: Public functions
    
    public func animateSubviewsGoingNext(next: Bool) {
        animateContainerGoingNext(next)
    }
    
    public override func refreshUserInterface() {
        super.refreshUserInterface()
        refreshImageView()
        refreshTitleLabel()
        refreshTextView()
        refreshButton(closeButton, withIdentifier: "close")
        refreshButton(previousButton, withIdentifier: "previous")
        refreshButton(nextButton, withIdentifier: "next")
        refreshButton(proceedButton, withIdentifier: "proceed")
        refreshButtons()
        refreshPageControl()
    }
    
    public func refreshButton(button: UIButton!, withIdentifier identifier: String) {
        let key = tutorial!.getResourceName(identifier)
        if (translationExists(key)) {
            button?.setTitle(translate(key), forState: .Normal)
        }
    }
    
    public func refreshButtons() {
        previousButton?.hidden = tutorial!.isFirstPage
        nextButton?.hidden = tutorial!.isLastPage
        proceedButton?.hidden = !tutorial!.isLastPage
    }
    
    public func refreshImageView() {
        let key = tutorial!.getResourceName("image")
        if (translationExists(key)) {
            let imageName = translate(key)
            let image = UIImage(named: imageName)
            imageView?.image = image
        } else {
            imageView?.image = nil
        }
    }
    
    public func refreshPageControl() {
        pageControl?.hidden = tutorial.pageCount < 2;
        pageControl?.currentPage = tutorial.currentPageIndex
        pageControl?.numberOfPages = tutorial.pageCount
    }
    
    public func refreshTitleLabel() {
        let key = tutorial!.getResourceName("title")
        if (translationExists(key)) {
            titleLabel?.text = translate(key)
        }
    }
    
    public func refreshTextView() {
        let key = tutorial!.getResourceName("text")
        if (translationExists(key)) {
            textView?.text = translate(key)
        }
    }
    
    public override func showTutorial(tutorial: Tutorial, inView view: UIView) -> Bool {
        let show = super.showTutorial(tutorial, inView:view)
        if (show) {
            self.view.frame = self.view.frameBelow
            let anim = { self.view.frame = self.view.frameAbove }
            UIView.animateWithDuration(slideDuration, delay: 0, options: .CurveEaseOut, animations: anim, completion: nil)
        }
        return show
    }
    
    
    
    // MARK: Private functions
    
    private func animateContainerGoingNext(next: Bool) {
        let animation = CATransition()
        animation.duration = swipeDuration
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = kCATransitionPush
        animation.subtype = next ? kCATransitionFromRight : kCATransitionFromLeft
        containerView.layer.addAnimation(animation, forKey: nil)
    }
}
