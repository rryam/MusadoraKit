// swift-tools-version:6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MusadoraKit",
    platforms: [.iOS(.v15), .macOS(.v12), .watchOS(.v8), .tvOS(.v15), .visionOS(.v1)],
    products: [
        .library(name: "MusadoraKit", targets: ["MusadoraKit"]),
        .executable(name: "musadora", targets: ["MusadoraCLI"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.4.0"),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.3.0")
    ],
    targets: [
        .target(
            name: "MusadoraKit",
            dependencies: [],
            resources: [
                .copy("PrivacyInfo.xcprivacy"),
                .process("Resources")
            ],
            swiftSettings: [
                .enableUpcomingFeature("StrictConcurrency")
            ]
        ),
        .testTarget(
            name: "MusadoraKitTests",
            dependencies: ["MusadoraKit"],
            resources: [.process("Fixtures")]
        ),
        .executableTarget(
            name: "MusadoraCLI",
            dependencies: [
                "MusadoraKit",
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ],
            swiftSettings: [
                .define("MUSADORA_CLI")
            ]
        )
    ]
)
