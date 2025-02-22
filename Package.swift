// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SRHealthKitManager",
    platforms: [
        .iOS(.v13),
        .macOS(.v13),
        .tvOS(.v13),
        .watchOS(.v7)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SRHealthKitManager",
            targets: ["SRHealthKitManager"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SRHealthKitManager"),

    ],
    swiftLanguageModes: [.v6,.v5]
)
