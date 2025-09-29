// Copyright © Fleuronic LLC. All rights reserved.

import Foundation

public protocol ValueEncodable: CustomStringConvertible, Sendable {
	associatedtype EncodedValue

	static func encode(with value: EncodedValue) -> Self
}

// MARK: -
extension String: ValueEncodable {
	public static func encode(with value: String) -> Self { value }
}

// MARK: -
extension Int: ValueEncodable {
	public static func encode(with value: Int) -> Self { value }
}

// MARK: -
extension UUID: ValueEncodable {
	public static func encode(with value: String) -> Self { .init(uuidString: value)! }
}
