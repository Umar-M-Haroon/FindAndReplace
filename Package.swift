// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ELOKA scraper",
    products: [
        .executable(name: "scraper", targets: ["ELOKA scraper"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-package-manager.git", from: "0.1.0")
    ],
    targets: [
        .target(
            name: "ELOKA scraper",
            dependencies: ["SPMUtility"]),
        .testTarget(
            name: "ELOKA scraperTests",
            dependencies: ["ELOKA scraper"]),
    ]
)
