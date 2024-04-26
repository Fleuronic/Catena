// Copyright © Fleuronic LLC. All rights reserved.

import struct Identity.Identifier

public protocol PathComponent {
	var rawValue: String { get }
}

private struct StringPathComponent: PathComponent {
	let rawValue: String
}

public prefix func /(component: CustomStringConvertible?) -> PathComponent? {
	(component?.description).map(StringPathComponent.init)
}

public prefix func /<T: RawRepresentable>(component: T?) -> PathComponent? where T.RawValue == String {
	(component?.rawValue).map(StringPathComponent.init)
}

prefix operator /
