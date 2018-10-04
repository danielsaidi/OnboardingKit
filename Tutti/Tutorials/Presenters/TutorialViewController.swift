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

open class TutorialViewController: UIViewController, TutorialPresenter, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    // MARK: View Controller Lifecycle
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        update()
    }
    
    
    // MARK: - Properties
    
    open var cellType: UICollectionViewCell.Type = TutorialViewControllerCell.self
    
    open var transition: TutorialTransition = FadeInTransition()
    
    open var tutorial: Tutorial?
    
    
    // MARK: - Private Properties
    
    fileprivate var cellClassName: String {
        return String(describing: cellType)
    }
    
    fileprivate var cellReuseIdentifier: String {
        return cellClassName
    }
    
    
    // MARK: Outlets
    
    @IBOutlet open weak var closeButton: UIButton?
    
    @IBOutlet open weak var collectionView: UICollectionView? {
        didSet {
            collectionView?.delegate = self
            collectionView?.dataSource = self
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            collectionView?.collectionViewLayout = layout
            let reuseId = cellReuseIdentifier
            let nib = UINib(nibName: cellClassName, bundle: nil)
            collectionView?.register(nib, forCellWithReuseIdentifier: reuseId)
        }
    }
    
    @IBOutlet open weak var nextButton: UIButton?
    
    @IBOutlet open weak var pageControl: UIPageControl?
    
    @IBOutlet open weak var previousButton: UIButton?
    
    
    // MARK: - Actions
    
    @IBAction func dismissTutorial(_ sender: Any) {
        guard let tutorial = tutorial else { return }
        dismiss(tutorial)
    }
    
    @IBAction func showNextPage(_ sender: Any) {
        guard let view = collectionView else { return }
        view.setPageIndex(view.pageIndex + 1, animated: true)
    }
    
    @IBAction func showPreviousPage(_ sender: Any) {
        guard let view = collectionView else { return }
        view.setPageIndex(view.pageIndex - 1, animated: true)
    }
    
    
    // MARK: - TutorialPresenter Functions
    
    open func dismiss(_ tutorial: Tutorial) {
        dismiss(animated: true, completion: nil)
    }
    
    open func present(_ tutorial: Tutorial, in vc: UIViewController, from view: UIView) {
        tryPresent(tutorial) {
            self.tutorial = tutorial
            transitioningDelegate = self
            vc.present(self, animated: true, completion: nil)
        }
    }
    
    
    // MARK: - Update Functions
    
    open func update() {
        updateCollectionView()
        updatePageControl()
        updateNextButton()
        updatePreviousButton()
        updateCloseButton()
    }
    
    open func updateCloseButton() { }
    
    open func updateCollectionView() {
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.isPagingEnabled = true
    }
    
    open func updateNextButton() {
        nextButton?.isHidden = tutorial?.isLastPage ?? true
    }
    
    open func updatePageControl() {
        guard let tutorial = tutorial else { return }
        pageControl?.isHidden = tutorial.pageCount < 2
        pageControl?.currentPage = tutorial.currentPageIndex
        pageControl?.numberOfPages = tutorial.pageCount
    }
    
    open func updatePreviousButton() {
        previousButton?.isHidden = tutorial?.isFirstPage ?? true
    }
    
    open func updateTutorial(with scrollView: UIScrollView) {
        tutorial?.currentPageIndex = scrollView.pageIndex
        update()
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
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard
            let tutorial = tutorial,
            let cell = cell as? TutorialViewControllerCell
            else { return }
        cell.update(with: tutorial, at: indexPath.row)
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
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updateTutorial(with: scrollView)
    }
    
    public func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        updateTutorial(with: scrollView)
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
