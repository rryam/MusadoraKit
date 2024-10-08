// swift-tools-version:5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "MusadoraKit",
  platforms: [.iOS(.v15), .macOS(.v12), .watchOS(.v8), .tvOS(.v15), .visionOS(.v1)],
  products: [
    .library(name: "MusadoraKit", targets: ["MusadoraKit"])
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0")
  ],
  targets: [
    .target(name: "MusadoraKit", dependencies: []),
    .testTarget(name: "MusadoraKitTests", dependencies: ["MusadoraKit"])
  ]
)
