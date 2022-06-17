import ProjectDescription

let dependencies = Dependencies(
  swiftPackageManager: [
    .remote(
      url: "https://github.com/facebook/facebook-ios-sdk",
      requirement: .upToNextMajor(from: "12.1.0")
    )
  ],
  platforms: [.iOS]
)
