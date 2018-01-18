//
//  TutorialViewController.swift
//  Tutti
//
//  Created by Daniel Saidi 2017-12-07.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

/*
 
 This view controller is a `TutorialPresenter` that displays
 multi-page tutorials in a horizontal, paged collection view.
 To use it, create a xib or storyboard view controller. Make
 it inherit this class, then setup any outlets as usual.
 
 To modify how the view controller updates its content, just
 subclass it and override any functions needed.
 
 The `collectionView` will register and dequeue cells of the
 `cellType` property type. The app must have a xib file with
 this type name (by default `TutorialViewControllerCell`) to
 be order to dequeue cells for the collection view.
 
 */

import UIKit

open class TutorialViewController: UIViewController, TutorialPresenter, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    // MARK: View Controller Lifecycle
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        update()
    }
    
    
    // MARK: - Properties
    
    open var cellType: UICollectionViewCell.Type = TutorialViewControllerCell.self
    
    open var transition: TutorialTransition = FadeInTransition()
    
    open var tutorial: Tutorial?
    
    fileprivate var cellReuseIdentifier: String {
        return String(describing: cellType)
    }
    
    
    // MARK: Outlets
    
    @IBOutlet open weak var closeButton: UIButton?
    
    @IBOutlet open weak var collectionView: UICollectionView? {
        didSet {
            guard let view = collectionView else { return }
            view.delegate = self
            view.dataSource = self
            let nib = UINib(nibName: cellReuseIdentifier, bundle: nil)
            view.register(nib, forCellWithReuseIdentifier: cellReuseIdentifier)
        }
    }
    
    @IBOutlet open weak var nextButton: UIButton?
    
    @IBOutlet open weak var pageControl: UIPageControl?
    
    @IBOutlet open weak var previousButton: UIButton?
    
    
    // MARK: - Actions
    
    @IBAction func dismissTutorial(_ sender: Any) {
        guard let tutorial = tutorial else { return }
        dismiss(tutorial: tutorial)
    }
    
    
    // MARK: - TutorialPresenter Functions
    
    open func dismiss(tutorial: Tutorial) {
        dismiss(animated: true, completion: nil)
    }
    
    open func present(tutorial: Tutorial, in vc: UIViewController, from view: UIView) -> Bool {
        if tutorial.hasBeenDisplayed { return false }
        tutorial.hasBeenDisplayed = true
        self.tutorial = tutorial
        transitioningDelegate = self
        vc.present(self, animated: true, completion: nil)
        return true
    }
    
    
    // MARK: - Update Functions
    
    open func update() {
        guard let tutorial = tutorial else { return }
        update(button: closeButton, buttonId: "close", for: tutorial)
        update(button: previousButton, buttonId: "previous", for: tutorial)
        update(button: nextButton, buttonId: "next", for: tutorial)
        previousButton?.isHidden = tutorial.isFirstPage
        nextButton?.isHidden = tutorial.isLastPage
    }
    
    open func update(button: UIButton?, buttonId: String, for tutorial: Tutorial) {
        let key = tutorial.resourceName(for: buttonId)
        button?.setTitle(translate(key), for: .normal)
    }
    
    open func update(pageControl: UIPageControl?, for tutorial: Tutorial) {
        pageControl?.isHidden = tutorial.pageCount < 2
        pageControl?.currentPage = tutorial.currentPageIndex
        pageControl?.numberOfPages = tutorial.pageCount
    }
    
    open func update(scrollView: UIScrollView?, for tutorial: Tutorial) {
        scrollView?.isPagingEnabled = true
    }
    
    
    // MARK: - Public Functions
    
    open func translate(_ key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
    
    
    // MARK: - UICollectionViewDataSource
    
    open func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    open func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tutorial?.pageCount ?? 0
    }
    
    open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(
            withReuseIdentifier: cellReuseIdentifier,
            for: indexPath)
    }
    
    
    // MARK: - UICollectionViewDelegate
    
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
        
    open func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


// MARK: - UIScrollViewDelegate

extension TutorialViewController: UIScrollViewDelegate {
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.currentPage
        if page != tutorial?.currentPageIndex {
            tutorial?.currentPageIndex = page
            pageControl?.currentPage = page
            update()
        }
    }
}


// MARK: - UIViewControllerTransitioningDelegate

extension TutorialViewController: UIViewControllerTransitioningDelegate {
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
}
