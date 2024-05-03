// Copyright © Fleuronic LLC. All rights reserved.

import InitMacro

extension Request {
	@Init public struct Method {
		let value: String
	}
}

// MARK: -
extension Request.Method {
	static let get = Self(value: "GET")
	static let post = Self(value: "POST")
	static let put = Self(value: "PUT")
	static let delete = Self(value: "DELETE")
}
