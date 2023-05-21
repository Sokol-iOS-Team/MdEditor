import ProjectDescription

let target = Target(
	name: "MdEditor",
	platform: .iOS,
	product: .app,
	productName: "MdEditor",
	bundleId: "com.ArtemSokolovskiy.MdEditor",
	deploymentTarget: .iOS(targetVersion: "16.2", devices: .iphone),
	infoPlist: "MdEditor/Supporting Files/Info.plist",
	sources: ["MdEditor/Sources/**"],
	resources: ["MdEditor/Resources/**"],
	dependencies: [
		.external(name: "PinLayout")
	]
)

//let testTarget = Target(
//	name: "MdEditorTests",
//	platform: .iOS,
//	product: .unitTests,
//	bundleId: "com.ArtemSokolovskiy.MdEditorTests",
//	deploymentTarget: .iOS(targetVersion: "16.2", devices: .iphone),
//	infoPlist: "MdEditor/Supporting Files/Info.plist",
//	sources: ["MdEditorTests/Sources/**"],
//	dependencies: [
//		.target(name: "MdEditor")
//	]
//)

let project = Project(
	name: "MdEditor",
	organizationName: "Sokol-iOS-Team",
	targets: [target], //, testTarget
	schemes: [
		Scheme(
			name: "MdEditor",
			shared: true,
			buildAction: .buildAction(targets: ["MdEditor"]),
			//testAction: .targets(["MdEditorTests"]),
			runAction: .runAction(executable: "MdEditor")
		)//,
//		Scheme(
//			name: "MdEditorTests",
//			shared: true,
//			buildAction: .buildAction(targets: ["MdEditorTests"]),
//			testAction: .targets(["MdEditorTests"]),
//			runAction: .runAction(executable: "MdEditorTests")
//		)
	]
)
