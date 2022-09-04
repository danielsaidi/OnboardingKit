// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "Tutti",
    platforms: [
        .iOS(.v9),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "Tutti",
            targets: ["Tutti"])
    ],
    dependencies: [
        .package(url: "https://github.com/danielsaidi/Quick.git", branch: "main"),
        .package(url: "https://github.com/danielsaidi/Nimble.git", branch: "main")
    ],
    targets: [
        .target(
            name: "Tutti",
            dependencies: []),
        .testTarget(
            name: "TuttiTests",
            dependencies: ["Tutti", "Quick", "Nimble"])
    ]
)
