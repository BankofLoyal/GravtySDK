// swift-tools-version:5.6
import PackageDescription

// SwiftPM equivalent of GravtySDK.podspec.
//
// The compiled `GravtySDK.xcframework` is vended as a binary target. SwiftPM
// does not allow `.binaryTarget` to declare package dependencies directly, so a
// thin wrapper target (`GravtySDKDependencies`) carries the three transitive
// dependencies declared in the podspec and re-exports the binary module. The
// `GravtySDK` library product bundles both targets, so a consumer that adds
// `GravtySDK` gets the xcframework plus Moya, SwiftKeychainWrapper and
// AnyCodable, matching the CocoaPods behavior. Public APIs remain reachable via
// `import GravtySDK`.
let package = Package(
    name: "GravtySDK",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "GravtySDK",
            targets: ["GravtySDK", "GravtySDKDependencies"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/Moya/Moya.git", exact: "15.0.0"),
        .package(url: "https://github.com/jrendel/SwiftKeychainWrapper.git", exact: "4.0.1"),
        .package(url: "https://github.com/Flight-School/AnyCodable.git", exact: "0.6.5")
    ],
    targets: [
        .binaryTarget(
            name: "GravtySDK",
            path: "GravtySDK.xcframework"
        ),
        .target(
            name: "GravtySDKDependencies",
            dependencies: [
                "GravtySDK",
                .product(name: "Moya", package: "Moya"),
                .product(name: "SwiftKeychainWrapper", package: "SwiftKeychainWrapper"),
                .product(name: "AnyCodable", package: "AnyCodable")
            ],
            path: "Sources/GravtySDKDependencies"
        )
    ],
    swiftLanguageVersions: [.v5]
)
