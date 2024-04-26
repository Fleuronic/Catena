// Copyright © Fleuronic LLC. All rights reserved.

import struct Identity.Identifier

public protocol PathComponent {
	var rawValue: String { get }
}

// MARK: -
public extension PathComponent where Self: CustomStringConvertible {
	var rawValue: String { description }
}

// MARK: -
extension String: PathComponent {}

// MARK: -
extension Identifier: PathComponent {}
