//
//  DemoPage.swift
//  Demo
//
//  Created by Daniel Saidi on 2024-05-28.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import OnboardingKit
import SwiftUI

struct DemoPage<Button: View>: View {

    let page: LocalizedOnboardingFlow.Page
    let info: OnboardingPageInfo
    let button: () -> Button

    var body: some View {
        ZStack {
            pageColor(at: info.currentPageIndex)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Image(page.imageName ?? "")
                Text(page.title).font(.title)
                Text(page.text)
                button()
            }
            .multilineTextAlignment(.center)
            .padding()
            .foregroundColor(.white)
        }
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

#Preview {
    DemoPage(
        page: .init(
            title: "Foo",
            text: "Bar"
        ),
        info: .init(
            pageIndex: 0,
            currentPageIndex: 1,
            totalPageCount: 2
        )
    ) {
        Button("Foo") {

        }
        .buttonStyle(.borderedProminent)
    }
}
