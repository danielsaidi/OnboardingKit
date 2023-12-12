// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "OnboardingKit",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6)
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
