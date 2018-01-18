//
//  TutorialTransition.swift
//  Tutti
//
//  Created by Daniel Saidi on 2018-01-18.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import UIKit

public protocol TutorialTransition: UIViewControllerAnimatedTransitioning {

    var isPresenting: Bool { get set }
}
