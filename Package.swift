// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "MMMPromisingResult",
    platforms: [
        .iOS(.v11),
        .watchOS(.v3),
        .tvOS(.v10),
        .macOS(.v10_12)
    ],
    products: [
        .library(
            name: "MMMPromisingResult",
            targets: ["MMMPromisingResult"]
		)
    ],
    dependencies: [],
    targets: [
        .target(
            name: "MMMPromisingResult",
            dependencies: [],
            path: "Sources/MMMPromisingResult"
		),
        .testTarget(
            name: "MMMPromisingResultTests",
            dependencies: ["MMMPromisingResult"],
            path: "Tests"
		)
    ]
)
