import ProjectDescription

public extension SettingValue {
  static let marketingVersion: SettingValue = "1.0"
  static let projectVersion: SettingValue = "1"
}

let scripts: [TargetScript] = [
//  TargetScript.pre(
//    script: "\"$PODS_ROOT/R.swift/rswift\" generate \"$SRCROOT/$PROJECT_NAME/Resource/AutoGenerated/R.generated.swift\"",
//    name: "R.swift",
//    inputPaths: [Path("$TEMP_DIR/rswift-lastrun")],
//    outputPaths: [Path("$SRCROOT/$PROJECT_NAME/Resource/AutoGenerated/R.generated.swift")]
//  ),
//  TargetScript.post(
//    script: "\"${PODS_ROOT}/SwiftLint/swiftlint\"",
//    name: "Swift Lint"
//  )
]

let baseSettings: [String: SettingValue] = [
  "CURRENT_PROJECT_VERSION": .projectVersion,
  "MARKETING_VERSION": .marketingVersion
]

let settings = Settings.settings(
  base: baseSettings,
  defaultSettings: .recommended
)

let target = Target(
  name: "GithubSearch",
  platform: .iOS,
  product: .app,
  bundleId: "com.wotjd.GithubSearch",
  deploymentTarget: .iOS(
    targetVersion: "15.4",
    devices: [.iphone]
  ),
  infoPlist: "GithubSearch/Support/Info.plist",
  sources: ["GithubSearch/Source/**"],
  resources: ["GithubSearch/Resource/**"],
  scripts: scripts,
  settings: settings
)

let project = Project(
  name: "GithubSearch",
  targets: [target]
)
