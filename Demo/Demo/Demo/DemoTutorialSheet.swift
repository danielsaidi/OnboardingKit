//
//  DemoTutorialSheet.swift
//  Demo
//
//  Created by Daniel Saidi on 2021-09-23.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI
import OnboardingKit

/**
 This tutorial is just a multi-page tab that presents a page
 for each page in the tutorial.
 */
struct DemoTutorialSheet: View {
    
    let tutorial: Tutorial
    
    var body: some View {
        TabView {
            ForEach(Array(tutorial.pages.enumerated()), id: \.offset) {
                pageView(for: $0.element)
            }
        }
        .padding()
        .tabViewStyle(.page)
        .background(Color.gray)
        .edgesIgnoringSafeArea(.all)
    }
}

private extension DemoTutorialSheet {
    
    func pageView(for page: TutorialPage) -> some View {
        VStack(spacing: 30) {
            Text(page.title).font(.title)
            Image(page.imageName ?? "")
            Text(page.text)
                .font(.body)
                .multilineTextAlignment(.center)
        }
    }
}

struct DemoTutorial_Previews: PreviewProvider {
    
    static var previews: some View {
        DemoTutorialSheet(tutorial: .demoLocalized)
    }
}
