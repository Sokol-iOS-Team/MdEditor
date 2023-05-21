import ProjectDescription

let description = Dependencies(
	swiftPackageManager: [
		.remote(url: "https://github.com/layoutBox/PinLayout", requirement: .exact("1.9.4"))//,
		//.local(path: "../Framework/CustomPackage")
	],
	platforms: [.iOS]
)
