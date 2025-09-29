// Copyright © Fleuronic LLC. All rights reserved.

import Foundation

public protocol IntEncodable: CustomStringConvertible, Sendable {
	static func encode(with value: Int) -> Self
}

// MARK: -
public protocol StringEncodable: CustomStringConvertible, Sendable {
	static func encode(with value: String) -> Self
}

// MARK: -
extension Int: IntEncodable {
	public static func encode(with value: Int) -> Self { value }
}

// MARK: -
extension String: StringEncodable {
	public static func encode(with value: String) -> Self { value }
}

// MARK: -
extension UUID: StringEncodable {
	public static func encode(with value: String) -> Self { .init(uuidString: value)! }
}
