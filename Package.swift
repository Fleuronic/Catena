// swift-tools-version:5.6
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
		.package(url: "https://github.com/JohnSundell/Identity", from: "0.1.0"),
		.package(url: "https://github.com/Fleuronic/Schemata", branch: "master"),
		.package(url: "https://github.com/Fleuronic/PersistDB", branch: "master"),
		.package(url: "https://github.com/LeonardoCardoso/InitMacro.git", branch: "main")
	],
	targets: [
		.target(
			name: "Catena",
			dependencies: [
				"Identity",
				"Schemata",
				"PersistDB",
				"InitMacro"
			]
		)
	]
)
