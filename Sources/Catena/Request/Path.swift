// Copyright © Fleuronic LLC. All rights reserved.

import struct Identity.Identifier

public protocol PathComponent {
	var rawValue: String { get }
}

public extension PathComponent where Self: CustomStringConvertible {
	var rawValue: String { description }
}

extension String: PathComponent {}

extension Identifier: PathComponent {}
