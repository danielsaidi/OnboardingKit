//
//  TutorialViewController.swift
//  Tutti
//
//  Created by Daniel Saidi on 2015-04-16.
//  Copyright (c) 2015 Daniel Saidi. All rights reserved.
//

import UIKit


@objc public protocol TutorialViewControllerDelegate {
    func tutorialViewController(tutorial: TutorialViewController, didTriggerAction action: String)
    func tutorialViewControllerDidFinish(tutorial: TutorialViewController)
}


public class TutorialViewController: UIViewController {
    
    
    // MARK: Properties
    
    public weak var delegate: TutorialViewControllerDelegate? = nil
    
    public var tutorial: Tutorial!
    
    
    
    // MARK: Outlets
    
    @IBOutlet public weak var actionButton: UIButton!
    @IBOutlet public weak var actionButtonContainer: UIView!
    
    
    
    // MARK: Actions
    
    @IBAction public func close(sender: AnyObject) {
        tutorial.hasBeenDisplayed = true
        view.removeFromSuperview()
        delegate?.tutorialViewControllerDidFinish(self)
    }
    
    @IBAction public func next(sender: AnyObject) {
        if (tutorial.next()) {
            refreshUserInterface()
        }
    }
    
    @IBAction public func previous(sender: AnyObject) {
        if (tutorial.previous()) {
            refreshUserInterface()
        }
    }
    
    @IBAction public func proceed(sender: AnyObject) {
        tutorial.isLastPage ? close(sender) : next(sender)
    }
    
    
    
    // MARK: Public methods
    
    public func refreshUserInterface() {
        //Implement in subclasses
    }
    
    public func showTutorial(tutorial: Tutorial, inView view: UIView) -> Bool {
        if (tutorial.hasBeenDisplayed) {
            delegate?.tutorialViewControllerDidFinish(self)
            return false
        }
        
        self.tutorial = tutorial
        view.addSubview(self.view)
        refreshUserInterface()
        return true
    }
}
