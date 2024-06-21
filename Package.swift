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
	targets: [
		.target(
			name: "Catena"
		)
	]
)
