//
//  TutorialViewController.swift
//  Tutti
//
//  Created by Daniel Saidi 2017-12-07.
//  Copyright © 2017 Daniel Saidi. All rights reserved.
//

/*
 
 This base view controller can be used to display a tutorial
 and its pages in a side-swiping, paged collection view.
 
 To use this class in your app, create a xib or a storyboard
 view controller that inherits this class. Setup any outlets
 you want to use by connecting them as usual. Have a look in
 the example app for a demo.
 
 To modify how the view controller updates its content, just
 subclass it and override any of the `update` functions.
 
 The `collectionView` will register and dequeue cells with a
 `TutorialPageCell` identifier. This means that you must add
 a `TutorialPageCell` xib to the app and have it inherit the
 `TutorialPageCell`. For more information on how to subclass
 `TutorialPageCell` or completely replace it, have a look in
 the `TutorialPageCell` class documentation.
 
 */

import UIKit

open class TutorialViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    // MARK: View Controller Lifecycle
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        update()
    }
    
    
    // MARK: - Properties
    
    open var transition = FadeInTransition()
    
    open var tutorial: Tutorial?
    
    open var cellReuseIdentifier = "TutorialPageCell"
    
    
    // MARK: Outlets
    
    @IBOutlet open weak var closeButton: UIButton?
    
    @IBOutlet open weak var collectionView: UICollectionView? {
        didSet {
            guard let view = collectionView else { return }
            view.delegate = self
            view.dataSource = self
            let id = cellReuseIdentifier
            let nib = UINib(nibName: id, bundle: nil)
            view.register(nib, forCellWithReuseIdentifier: id)
        }
    }
    
    @IBOutlet open weak var nextButton: UIButton?
    
    @IBOutlet open weak var pageControl: UIPageControl?
    
    @IBOutlet open weak var previousButton: UIButton?
    
    
    // MARK: - Actions
    
    @IBAction func dismissTutorial(_ sender: Any) {
        guard let tutorial = tutorial else { return }
        tutorial.presenter?.dismiss(tutorial: tutorial)
    }
    
    
    // MARK: - Update Functions
    
    open func update() {
        guard let tutorial = tutorial else { return }
        update(button: closeButton, id: "close", for: tutorial)
        update(button: previousButton, id: "previous", for: tutorial)
        update(button: nextButton, id: "next", for: tutorial)
        previousButton?.isHidden = tutorial.isFirstPage
        nextButton?.isHidden = tutorial.isLastPage
    }
    
    open func update(button: UIButton?, id: String, for tutorial: Tutorial) {
        let key = tutorial.resourceName(for: id)
        button?.setTitle(translate(key), for: .normal)
    }
    
    open func update(pageControl: UIPageControl?, for tutorial: Tutorial) {
        pageControl?.isHidden = tutorial.pageCount < 2;
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
        let id = cellReuseIdentifier
        return collectionView.dequeueReusableCell(withReuseIdentifier: id, for: indexPath)
    }
    
    
    // MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
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
