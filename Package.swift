// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-json-ld",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "JSONLD",
            targets: ["JSONLD"]),
    ],
    dependencies: [
        .package(url: "https://github.com/sinoru/swift-json-value.git", from: "0.0.1")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "JSONLD",
            dependencies: [.product(name: "JSONValue", package: "swift-json-value")]),
        .testTarget(
            name: "JSONLDTests",
            dependencies: ["JSONLD"]),
    ]
)
