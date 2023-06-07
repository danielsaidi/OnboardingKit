//
//  Tutorial+Demo.swift
//  Demo
//
//  Created by Daniel Saidi on 2021-09-23.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import OnboardingKit

extension Tutorial {
    
    static let demoStandard = Tutorial(pages: [
        TutorialPage(
            title: "Standard tutorial",
            text: "This tutorial was created in code, by manually creating pages in the demo code.",
            imageName: "tutorial.0.image"),
        TutorialPage(
            title: "Easy to create",
            text: "It's really easy to create tutorials in this way, but it can also be tedious.",
            imageName: "tutorial.1.image"),
        TutorialPage(
            title: "Localized tutorials",
            text: "It's more convenient and efficient to use localized tutorials. See the demo for examples.",
            imageName: "tutorial.2.image")
    ])

    static let demoCorrectBehavior = LocalizedTutorial(
        id: "correct-behavior")
    
    static let demoDelayed = Tutorial(pages: [
        TutorialPage(
            title: "Delayed tutorial",
            text: "You can present any tutorial as a delayed onboarding experience, that requires a certain number of attempts before being presented.",
            imageName: "tutorial.0.image"),
        TutorialPage(
            title: "When to use it?", text: "Delayed onboarding experiences are great when you want to present a hint or tutorial after a while.", imageName: "tutorial.1.image")])
    
    static let demoLocalized = LocalizedTutorial(
        id: "localized")
}
