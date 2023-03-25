// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ExtensionHelper7",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "ExtensionHelper7",
            targets: ["ExtensionHelper7"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/danha1998/ExtensionHelper7", from: "1.0.0"),
        .package(url: "https://github.com/lachlanbell/SwiftOTP.git", .upToNextMinor(from: "3.0.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "ExtensionHelper7",
            dependencies: ["SwiftOTP"]),
        .testTarget(
            name: "ExtensionHelper7Tests",
            dependencies: ["ExtensionHelper7"]),
    ]
)
