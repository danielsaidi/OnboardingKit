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
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),
        .package(url: "https://github.com/Quick/Quick.git", .upToNextMajor(from: "4.0.0")),
        .package(url: "https://github.com/Quick/Nimble.git", .upToNextMajor(from: "9.2.0")),
        .package(url: "https://github.com/danielsaidi/MockingKit.git", .upToNextMajor(from: "0.9.4"))
    ],
    targets: [
        .target(
            name: "Tutti",
            dependencies: []),
        .testTarget(
            name: "TuttiTests",
            dependencies: ["Tutti", "Quick", "Nimble", "MockingKit"])
    ]
)
