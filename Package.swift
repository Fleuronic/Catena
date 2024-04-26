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
		.package(url: "https://github.com/LeonardoCardoso/InitMacro.git", branch: "main"),
		.package(url: "https://github.com/almazrafi/DictionaryCoder.git", from: "1.2.0"),
		.package(url: "https://github.com/FelixHerrmann/swift-multipart-formdata.git", from: "1.3.0")
	],
	targets: [
		.target(
			name: "Catena",
			dependencies: [
				"Identity",
				"InitMacro",
				"DictionaryCoder",
				.productItem(name: "MultipartFormData", package: "swift-multipart-formdata")
			]
		)
	]
)
