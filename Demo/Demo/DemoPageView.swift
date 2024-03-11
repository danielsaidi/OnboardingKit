//
//  DemoPageView.swift
//  Demo
//
//  Created by Daniel Saidi on 2024-03-11.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import OnboardingKit
import SwiftUI

struct DemoPageView: View {
    
    let flow: LocalizedOnboardingFlow
    
    @Binding var index: Int
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        OnboardingPageView(
            pages: Onboarding.demoLocalizedFlow.pages,
            pageIndex: $index
        ) { page, info in
            ZStack {
                pageColor(at: info.currentPageIndex)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Spacer()
                    Image(page.imageName ?? "")
                    Text(page.title).font(.title)
                    Text(page.text)
                    Spacer()
                    Button(info.isLastPage ? "Done" : "Next") {
                        if info.isLastPage { return dismiss() }
                        withAnimation {
                            index += 1
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                }
                .multilineTextAlignment(.center)
                .padding()
                .foregroundColor(.white)
            }
            .animation(.default, value: index)
        }
        .ignoresSafeArea()
        .onDisappear { index = 0 }
        .onboardingPageViewStyle(
            .init(
                pageIndicatorTintColor: .white.opacity(0.5),
                currentPageIndicatorTintColor: .white)
        )
    }
    
    func pageColor(at index: Int) -> Color {
        switch index {
        case 0: .red
        case 1: .green
        case 2: .blue
        default: .yellow
        }
    }
}

