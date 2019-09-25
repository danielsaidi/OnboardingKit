// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Tutti",
    platforms: [
        .iOS(.v9)
    ],
    products: [
        .library(
            name: "Tutti",
            targets: ["Tutti"])
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Quick.git", from: "2.1.0"),
        .package(url: "https://github.com/Quick/Nimble.git", .exact("8.0.2"))
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
