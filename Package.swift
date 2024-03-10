// swift-tools-version:5.9

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
    dependencies: [],
    targets: [
        .target(
            name: "OnboardingKit",
            dependencies: []
        ),
        .testTarget(
            name: "OnboardingKitTests",
            dependencies: ["OnboardingKit"]
        )
    ]
)
