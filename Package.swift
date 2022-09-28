// swift-tools-version: 5.7
import PackageDescription

let package = Package(
	name: "BoardingPassKit",
	products: [
		.library(
			name: "BoardingPassKit",
			targets: ["BoardingPassKit"]),
	],
	dependencies: [],
	targets: [
		.target(
			name: "BoardingPassKit",
			dependencies: [],
			path: "Sources"),
		.testTarget(
			name: "BoardingPassKitTests",
			dependencies: ["BoardingPassKit"],
			path: "Tests"),
	]
)
