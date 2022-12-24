// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "MusadoraKit",
  platforms: [.iOS(.v15), .macOS(.v12), .watchOS(.v8), .tvOS(.v15)],
  products: [
    .library(name: "MusadoraKit", targets: ["MusadoraKit"]),
    .library(name: "MusadoraLabsKit", targets: ["MusadoraLabsKit"]),
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),
  ],
  targets: [
    .target(name: "MusadoraKit", dependencies: []),
    .testTarget(name: "MusadoraKitTests", dependencies: ["MusadoraKit"]),
    .target(name: "MusadoraLabsKit", dependencies: []),
    .testTarget(name: "MusadoraLabsKitTests", dependencies: ["MusadoraLabsKit"]),
  ]
)
