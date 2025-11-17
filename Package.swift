// swift-tools-version:6.1

import PackageDescription

let package = Package(
    name: "OnboardingKit",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .tvOS(.v17),
        .watchOS(.v10),
        .visionOS(.v1)
    ],
    products: [
        .library(
            name: "OnboardingKit",
            targets: ["OnboardingKit"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/danielsaidi/PageView.git", .upToNextMajor(from: "0.2.0"))
    ],
    targets: [
        .target(
            name: "OnboardingKit",
            dependencies: ["PageView"]
        ),
        .testTarget(
            name: "OnboardingKitTests",
            dependencies: ["OnboardingKit"]
        )
    ]
)
