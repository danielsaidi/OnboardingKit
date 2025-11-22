//
//  WelcomeScreen.swift
//  Demo
//
//  Created by Daniel Saidi on 2025-11-19.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import OnboardingKit
import SwiftUI

struct WelcomeScreen: View {

    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                OnboardingIntroScreen(
                    icon: .init(.icon),
                    welcomeTitle: "Welcome to",
                    title: "OnboardingKit",
                    text: "Create amazing onboarding experiences in SwiftUI.",
                    usps: [
                        .init(
                            title: "Onboarding",
                            text: "Design great onboardings with various **onboarding types**.",
                            image: .init(systemName: "lightbulb")
                        ),
                        .init(
                            title: "Flows",
                            text: "Sophisticated **page views** and **slideshows**.",
                            image: .init(systemName: "appwindow.swipe.rectangle")
                        ),
                        .init(
                            title: "Views",
                            text: "Reduce implementation time with screen templates, buttons, etc.",
                            image: .init(systemName: "square")
                        )
                    ]
                )
                .padding()
                .frame(maxWidth: 450)
            }
            .toolbar {
                Button("Done") {
                    dismiss.callAsFunction()
                }
            }
        }
    }
}


#Preview {

    WelcomeScreen()
}
