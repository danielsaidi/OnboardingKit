// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "Tutti",
    platforms: [
        .iOS(.v9),
        .tvOS(.v13),
        .watchOS(.v6),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "Tutti",
            targets: ["Tutti"])
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Quick.git", .upToNextMajor(from: "3.0.0")),
        .package(url: "https://github.com/Quick/Nimble.git", .upToNextMajor(from: "8.0.0")),
        .package(url: "https://github.com/danielsaidi/Mockery.git", .upToNextMajor(from: "0.6.0"))
    ],
    targets: [
        .target(
            name: "Tutti",
            dependencies: []),
        .testTarget(
            name: "TuttiTests",
            dependencies: ["Tutti", "Quick", "Nimble", "Mockery"])
    ]
)
