// swift-tools-version: 5.6
import PackageDescription

let package = Package(
    name: "PackageName",
    dependencies: [
        .package(url: "https://github.com/facebook/facebook-ios-sdk", from: "12.1.0"),
    ]
)