// swift-tools-version:5.8
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
	dependencies: [.package(url: "https://github.com/Fleuronic/Identity", branch: "master")],
	targets: [
		.target(
			name: "Catena",
			dependencies: ["Identity"]
		)
	]
)

for target in package.targets {
	target.swiftSettings = [
		.enableUpcomingFeature("StrictConcurrency"),
	]
}
