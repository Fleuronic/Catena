// Copyright © Fleuronic LLC. All rights reserved.

import InitMacro
import MultipartFormData

import struct Foundation.URL
import struct Foundation.Data

@Init public struct Upload {
	let file: URL
	let name: String
	let filename: String
	
	var data: MultipartFormData {
		get throws {
			try MultipartFormData(boundary: .init(uncheckedBoundary: "boundary")) {
				try Subpart {
					try ContentDisposition(uncheckedName: name, uncheckedFilename: filename)
				} body: {
					try Data(contentsOf: file)
				}
			}
		}
	}
}
