//
//  PreviewPage.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2024-05-28.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

struct PreviewPage: View {

    @Binding var index: Int

    let info: OnboardingPageInfo<Int>

    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            Image(systemName: "\(info.pageIndex+1).circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 150)
                .shadow(radius: 1, y: 1)
            Text("This is page \(info.pageIndex+1) of \(info.totalPageCount).")
            Spacer()
        }
        .scaleEffect(info.isCurrentPage ? 1 : 0.4)
        .animation(.bouncy, value: index)
        .safeAreaInset(edge: .bottom) {
            Button(info.isLastPage ? "Done" : "Next") {
                withAnimation {
                    if info.isLastPage {
                        print("Done")
                    } else {
                        index += 1
                    }
                }
            }
            .shadow(radius: 1, y: 2)
            .buttonStyle(.borderedProminent)
            .padding()
        }
    }
}

#Preview {
    PreviewPage(
        index: .constant(1),
        info: .init(
            page: 1,
            pageIndex: 0,
            currentPageIndex: 0,
            totalPageCount: 2
        )
    )
}
