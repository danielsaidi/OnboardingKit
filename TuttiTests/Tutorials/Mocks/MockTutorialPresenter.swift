//
//  MockTutorialPresenter.swift
//  TuttiTests
//
//  Created by Daniel Saidi on 2018-06-19.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import UIKit
import Tutti

class MockTutorialPresenter: TutorialPresenter {
    
    var dismissInvokeCount = 0
    var dismissInvokeTutorials = [Tutorial]()
    
    var presentInvokeCount = 0
    var presentInvokeTutorials = [Tutorial]()
    var presentInvokeVcs = [UIViewController]()
    var presentInvokeViews = [UIView]()
    
    func dismiss(_ tutorial: Tutorial) {
        dismissInvokeCount += 1
        presentInvokeTutorials.append(tutorial)
    }
    
    func present(_ tutorial: Tutorial, in vc: UIViewController, from view: UIView) {
        presentInvokeCount += 1
        presentInvokeTutorials.append(tutorial)
        presentInvokeVcs.append(vc)
        presentInvokeViews.append(view)
    }
}
