// swift-tools-version:6.0

import PackageDescription

let package = Package(
    name: "OnboardingKit",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
        .tvOS(.v15),
        .watchOS(.v8),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "OnboardingKit",
            targets: ["OnboardingKit"]
        )
    ],
    targets: [
        .target(
            name: "OnboardingKit"
        ),
        .testTarget(
            name: "OnboardingKitTests",
            dependencies: ["OnboardingKit"]
        )
    ]
)
