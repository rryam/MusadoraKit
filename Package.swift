// swift-tools-version:6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
  name: "MusadoraKit",
  platforms: [.iOS(.v15), .macOS(.v12), .watchOS(.v8), .tvOS(.v15), .visionOS(.v1)],
  products: [
    .library(name: "MusadoraKit", targets: ["MusadoraKit"])
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),
    .package(url: "https://github.com/apple/swift-syntax.git", from: "600.0.0")
  ],
  targets: [
    .target(
      name: "MusadoraKit",
      dependencies: ["MusadoraKitMacros"]
    ),
    .macro(
      name: "MusadoraKitMacros",
      dependencies: [
        .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
        .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
      ]
    ),
    .testTarget(
      name: "MusadoraKitTests",
      dependencies: ["MusadoraKit"]
    ),
    .testTarget(
      name: "MusadoraKitMacrosTests",
      dependencies: [
        "MusadoraKitMacros",
        .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax")
      ]
    )
  ]
)
