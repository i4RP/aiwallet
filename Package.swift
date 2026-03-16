// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Pocket",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "Pocket",
            targets: ["Pocket"]
        ),
    ],
    targets: [
        .target(
            name: "Pocket",
            path: "Pocket/Sources"
        ),
    ]
)
