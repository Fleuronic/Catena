//
//  File.swift
//  Catena
//
//  Created by Jordan Kay on 5/23/25.
//

import Foundation

public protocol StringEncodable: CustomStringConvertible {
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
