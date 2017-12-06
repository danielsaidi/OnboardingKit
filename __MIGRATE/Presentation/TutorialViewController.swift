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
    
    
    
    // MARK: Outlets
    
    @IBOutlet open weak var closeButton: UIButton?
    @IBOutlet open weak var containerView: UIView?
    @IBOutlet open weak var imageView: UIImageView?
    @IBOutlet open weak var nextButton: UIButton?
    @IBOutlet open weak var pageControl: UIPageControl?
    @IBOutlet open weak var previousButton: UIButton?
    @IBOutlet open weak var proceedButton: UIButton?
    @IBOutlet open weak var textView: UITextView?
    @IBOutlet open weak var titleLabel: UILabel?
    
    
    
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
    
    open func refresh() {
        guard let tutorial = tutorial else { return }
        refresh(imageView)
        refresh(titleLabel: titleLabel)
        refresh(textView: textView)
        refresh(button: closeButton, withIdentifier: "close")
        refresh(button: previousButton, withIdentifier: "previous")
        refresh(button: nextButton, withIdentifier: "next")
        refresh(button: proceedButton, withIdentifier: "proceed")
        previousButton?.isHidden = tutorial.isFirstPage
        nextButton?.isHidden = tutorial.isLastPage
        proceedButton?.isHidden = !tutorial.isLastPage
        refresh(pageControl: pageControl)
    }
    
    open func refresh(button: UIButton?, withIdentifier identifier: String) {
        let key = tutorial!.getResourceName(key: identifier)
        if (translationExists(key)) {
            button?.setTitle(translate(key), for: UIControlState())
        }
    }
    
    open func refresh(_ imageView: UIImageView?) {
        let key = tutorial!.getResourceName(key: "")
        let image = UIImage(named: key)
        imageView?.image = image
    }
    
    open func refresh(pageControl: UIPageControl?) {
        guard let tutorial = tutorial else { return }
        pageControl?.isHidden = tutorial.pageCount < 2;
        pageControl?.currentPage = tutorial.currentPageIndex
        pageControl?.numberOfPages = tutorial.pageCount
    }
    
    open func refresh(textView: UITextView?) {
        guard let tutorial = tutorial else { return }
        let key = tutorial.getResourceName(key: "text")
        if (translationExists(key)) {
            textView?.text = translate(key)
        }
    }
    
    open func refresh(titleLabel: UILabel?) {
        guard let tutorial = tutorial else { return }
        let key = tutorial.getResourceName(key: "title")
        if (translationExists(key)) {
            titleLabel?.text = translate(key)
        }
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
