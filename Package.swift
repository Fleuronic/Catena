// swift-tools-version:5.10
// Copyright © Fleuronic LLC. All rights reserved.

import PackageDescription

let package = Package(
	name: "Catena",
	platforms: [
		.iOS(.v13),
		.macOS(.v10_15),
		.tvOS(.v13),
		.watchOS(.v6)
	],
	products: [
		.library(
			name: "Catena",
			targets: ["Catena"]
		)
	],
	dependencies: [
		.package(url: "https://github.com/Fleuronic/Identity", branch: "master"),
		.package(url: "https://github.com/Fleuronic/InitMacro.git", branch: "update-swift-syntax")
	],
	targets: [
		.target(
			name: "Catena",
			dependencies: [
				"Identity",
				"InitMacro"
			]
		)
	]
)
