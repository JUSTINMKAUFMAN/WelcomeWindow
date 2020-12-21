// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "WelcomeWindow",
    platforms: [.iOS(.v14), .macOS(.v11)],
    products: [
        .library(name: "WelcomeWindow", targets: ["WelcomeWindow"])
    ],
    dependencies: [],
    targets: [
        .target(
            name: "WelcomeWindow",
            dependencies: [],
            path: "WelcomeWindow"
        )
    ]
)
