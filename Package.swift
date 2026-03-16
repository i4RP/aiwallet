// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Pocket",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(
            name: "Pocket",
            targets: ["Pocket"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/privy-io/privy-ios", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "Pocket",
            dependencies: [
                .product(name: "PrivySDK", package: "privy-ios"),
            ],
            path: "Pocket/Sources"
        ),
    ]
)
