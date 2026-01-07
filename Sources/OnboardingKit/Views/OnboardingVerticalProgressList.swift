//
//  OnboardingVerticalProgressList.swift
//  OnboardingKit
//
//  Created by Daniel Saidi on 2025-11-22.
//  Copyright © 2025-2026 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI

/// This view can be used to list steps in a vertical list.
///
/// This view can be styled with``SwiftUICore/View/onboardingVerticalProgressListStyle(_:)`.
public struct OnboardingVerticalProgressList: View {

    public init(
        steps: [OnboardingVerticalProgressListStep],
        stepIndex: Int,
        bundle: Bundle? = nil
    ) {
        self.steps = steps
        self.currentStepIndex = stepIndex
        self.bundle = bundle ?? .main
    }

    public typealias Step = OnboardingVerticalProgressListStep

    private let steps: [Step]
    private let currentStepIndex: Int
    private let bundle: Bundle

    @Environment(\.onboardingVerticalProgressListStyle) var style

    public var body: some View {
        VStack(spacing: 0) {
            ForEach(Array(steps.enumerated()), id: \.offset) {
                listItem(for: $0.element, at: $0.offset)
            }
        }
    }
}

private extension OnboardingVerticalProgressList {

    func isActive(_ index: Int) -> Bool {
        index <= currentStepIndex
    }

    func isLast(_ index: Int) -> Bool {
        index == steps.count - 1
    }

    func circle(at index: Int) -> some View {
        let baseColor = style.circleColor
        let activeColor = style.circleActiveColor
        let color = isActive(index) ? activeColor : baseColor
        return ZStack(alignment: .top) {
            if !isLast(index) {
                Rectangle()
                    .frame(width: style.circleLineWidth)
                    .frame(maxHeight: .infinity)
            }
            Image(systemName: "\(index+1).circle.fill")
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .frame(width: style.circleSize)
                .symbolRenderingMode(.multicolor)
        }
        .foregroundStyle(color)
    }

    func textStack(for step: Step, at index: Int) -> some View {
        let baseColor = style.titleColor
        let activeColor = style.titleActiveColor
        let color = isActive(index) ? activeColor : baseColor
        return VStack(alignment: .leading) {
            Text(step.title, bundle: bundle)
                .bold()
                .foregroundStyle(color)
            Text(step.text, bundle: bundle)
                .discrete()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, style.stepSpacing)
        }
    }

    @ViewBuilder
    func listItem(
        for step: Step,
        at index: Int
    ) -> some View {
        VStack {
            textStack(for: step, at: index)
                .padding(.leading, style.circleSize + style.circleTextSpacing)
        }
        .background(circle(at: index), alignment: .topLeading)
    }
}

enum DemoOnboardingPage: Int, CaseIterable, Identifiable {

    case step1, step2, step3, step4

    var id: Int { rawValue }
    var pageIndex: Int { rawValue }
    var pageNumber: Int { pageIndex+1 }
    var icon: Image { Image(systemName: "\(pageNumber).circle.fill") }
    var title: String { "Step \(pageNumber)" }

    var text: String {
        switch self {
        case .step1: "The first step is the hardest. 😫"
        case .step2: "The second step is a bit easier. 😅"
        case .step3: "The third step is a victory! 🤩"
        case .step4: "You did it! 🥳"
        }
    }

    var accentColor: Color {
        switch self {
        case .step1: .red
        case .step2: .orange
        case .step3: .yellow
        case .step4: .green
        }
    }
}
#Preview {

    @Previewable @State var index = 0

    OnboardingVerticalProgressList(
        steps: [
            .init(title: "Step 1", text: "The first step is the hardest. 😫"),
            .init(title: "Step 2", text: "The second step is a bit easier. 😅"),
            .init(title: "Step 3", text: "The third step is a victory! 🤩"),
            .init(title: "Step 4", text: "You did it! 🥳")
        ],
        stepIndex: index
    )
    .padding()
}
