// swift-tools-version:5.6

import PackageDescription

let package = Package(
    name: "Tutti",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "Tutti",
            targets: ["Tutti"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Tutti",
            dependencies: []),
        .testTarget(
            name: "TuttiTests",
            dependencies: ["Tutti"])
    ]
)
