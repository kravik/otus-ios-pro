// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FootballService",
    platforms: [.iOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "FootballService",
            targets: ["FootballService"]),
    ],
    dependencies: [
        .package(
            name: "Networking",
            url: "../Networking",
            .exact("1.0.0")
        ),
    ],
    targets: [
        .target(
            name: "FootballService",
            dependencies: ["Networking"]),
    ]
)
