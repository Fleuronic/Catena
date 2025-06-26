// Copyright © Fleuronic LLC. All rights reserved.

import Foundation

public protocol StringEncodable: CustomStringConvertible, Sendable {
	static func encode(with string: String) -> Self
}

// MARK: -
extension String: StringEncodable {
	public static func encode(with string: String) -> Self {
		string
	}
}

// MARK: -
extension Int: StringEncodable {
	public static func encode(with string: String) -> Self {
		.init(string)!
	}
}

// MARK: -
extension UUID: StringEncodable {
	public static func encode(with string: String) -> Self {
		.init(uuidString: string)!
	}
}
