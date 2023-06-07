//
//  Hint+Demo.swift
//  Demo
//
//  Created by Daniel Saidi on 2021-09-23.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import OnboardingKit

extension Hint {
    
    static let demoStandard = Hint(
        title: "Standard hint",
        text: "A standard hint is presented right away. It is only presented once.")
    
    static let demoCorrectBehavior = Hint(
        title: "Incorrect behavior",
        text: "An incorrect behavior hint is presented after a certain number of incorrect actions. Use it to educate your users.")
    
    static let demoDelayed = Hint(
        title: "Delayed hint",
        text: "A delayed hint requires a certain number of presentation attemtps before being presented. It is only presented once.")
}
