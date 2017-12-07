//
//  TutorialViewController.swift
//  Tutti
//
//  Created by Daniel Saidi 2017-12-07.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

/*
 
 This is a base class for any tutorial view controllers your
 apps may use. It provides basic presentation and navigation
 logic, which you can extend with your own custom logic.
 
 The view controller contains a bunch of outlets that you'll
 have to set from your storyboards/xibs or set by code. Look
 at the demo app for an example on how to do this.
 
 The scroll view outlet should have the stack view outlet as
 an embedded subview (see the demo app). The view controller
 then add a `TutorialView` instance to the stack view outlet
 for every page in the tutorial.
 
 If you want to adjust any view handling whatsoever, you just
 have to override any of the `refresh` functions.
 
 */

import UIKit

open class TutorialViewController: UIViewController {
    
    
    // MARK: View Controller Lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        viewWillSetup()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
    }
    
    open func viewWillSetup() {
        clearStackView()
        populateStackView()
    }
    
    
    // MARK: - Properties
    
    open var tutorial: Tutorial?
    
    
    // MARK: Outlets
    
    @IBOutlet open weak var closeButton: UIButton?
    @IBOutlet open weak var nextButton: UIButton?
    @IBOutlet open weak var pageControl: UIPageControl?
    @IBOutlet open weak var previousButton: UIButton?
    @IBOutlet open weak var proceedButton: UIButton?
    @IBOutlet open weak var scrollView: UIScrollView?
    @IBOutlet open weak var stackView: UIStackView?
    
    
    // MARK: - Refresh Functions
    
    open func refresh() {
        guard let tutorial = tutorial else { return }
        refresh(button: closeButton, withIdentifier: "close", for: tutorial)
        refresh(button: previousButton, withIdentifier: "previous", for: tutorial)
        refresh(button: nextButton, withIdentifier: "next", for: tutorial)
        refresh(button: proceedButton, withIdentifier: "proceed", for: tutorial)
        previousButton?.isHidden = tutorial.isFirstPage
        nextButton?.isHidden = tutorial.isLastPage
        proceedButton?.isHidden = !tutorial.isLastPage
        refresh(pageControl: pageControl, for: tutorial)
        refresh(scrollView: scrollView, for: tutorial)
    }
    
    open func refresh(button: UIButton?, withIdentifier id: String, for tutorial: Tutorial) {
        let key = tutorial.resourceName(for: id)
        button?.setTitle(translate(key), for: .normal)
    }
    
    open func refresh(pageControl: UIPageControl?, for tutorial: Tutorial) {
        pageControl?.isHidden = tutorial.pageCount < 2;
        pageControl?.currentPage = tutorial.currentPageIndex
        pageControl?.numberOfPages = tutorial.pageCount
    }
    
    open func refresh(scrollView: UIScrollView?, for tutorial: Tutorial) {
        scrollView?.isPagingEnabled = true
    }
}


// MARK: - Private Functions

fileprivate extension TutorialViewController {
    
    func clearStackView() {
        stackView?.subviews.forEach {
            stackView?.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
    }
    
    func populateStackView() {
        // TBD:
    }
    
    func translate(_ key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
}


// MARK: - UIScrollViewDelegate

extension TutorialViewController: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.frame.size.width
        let page = Int((scrollView.contentOffset.x + (0.5 * width)) / width)
        if page != tutorial?.currentPageIndex {
            tutorial?.currentPageIndex = page
            refresh()
        }
    }
}
