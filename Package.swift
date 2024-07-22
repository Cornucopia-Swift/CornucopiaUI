// swift-tools-version:5.10

import PackageDescription

let package = Package(
    name: "CornucopiaUI",
    platforms: [
        .iOS(.v14),
        .macOS(.v12),
        .tvOS(.v14),
        .watchOS(.v8),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "CornucopiaUI",
            targets: ["CornucopiaUI"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/Cornucopia-Swift/CornucopiaCore", branch: "master"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "CornucopiaUI",
            dependencies: ["CornucopiaCore"]
        ),
        .testTarget(
            name: "CornucopiaUITests",
            dependencies: ["CornucopiaUI"]
        ),
    ]
)
