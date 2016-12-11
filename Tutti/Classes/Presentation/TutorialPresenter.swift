//
//  TutorialPresenter.swift
//  Tutti
//
//  Created by Daniel Saidi on 2016-12-11.
//  Copyright (c) 2016 Daniel Saidi. All rights reserved.
//
//

import UIKit

public protocol TutorialPresenter: class {

    func present(tutorial: Tutorial, in view: UIView) -> Bool
}
