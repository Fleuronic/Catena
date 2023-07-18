// swift-tools-version:5.7
// Copyright © Fleuronic LLC. All rights reserved.

import PackageDescription

let package = Package(
	name: "Catena",
	platforms: [
		.iOS(.v12),
		.macOS(.v10_13),
		.watchOS(.v6),
		.tvOS(.v12)
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
		.package(url: "https://github.com/Fleuronic/PersistDB", branch: "master")
	],
	targets: [
		.target(
			name: "Catena",
			dependencies: [
				"Identity",
				"Schemata",
				"PersistDB"
			]
		)
	]
)
