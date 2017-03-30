
import PackageDescription

let package = Package(
	name: "Jeeves",
	dependencies: [
        .Package(url: "https://github.com/PerfectlySoft/Perfect-HTTPServer.git", versions: Version(2,1,0)..<Version(2, 1, .max)),
        .Package(url: "https://github.com/PerfectlySoft/Perfect-CURL.git", versions: Version(2,0,0)..<Version(2, 0, .max)),
        .Package(url: "https://github.com/StartAppsPe/StartAppsKitExtensions.git", versions: Version(1,0,0)..<Version(1, .max, .max)),
        .Package(url: "https://github.com/StartAppsPe/StartAppsKitLogger.git", versions: Version(1,0,0)..<Version(1, .max, .max)),
        .Package(url: "https://github.com/StartAppsPe/Jessie.git", versions: Version(2,5,1)..<Version(2, .max, .max)),
        .Package(url: "https://github.com/kareman/SwiftShell", "3.0.0-beta")
    ]
)
