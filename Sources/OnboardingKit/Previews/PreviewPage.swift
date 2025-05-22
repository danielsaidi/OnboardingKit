//
//  PreviewPage.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2024-05-28.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI

struct PreviewPage: View {

    @Binding var index: Int

    let info: OnboardingPageInfo<Int>

    var body: some View {
        VStack(spacing: 30) {
            Image(systemName: "\(info.pageIndex+1).circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: 150)
                .shadow(radius: 1, y: 1)
            Text("This is page \(info.pageIndex+1) of \(info.totalPageCount).")
        }
        .padding()
        .background(.background, in: .rect(cornerRadius: 10))
        .scaleEffect(info.isCurrentPage ? 1 : 0.4)
        .animation(.bouncy, value: index)
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
