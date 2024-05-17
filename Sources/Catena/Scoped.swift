// Copyright © Fleuronic LLC. All rights reserved.

public protocol Scoped {
	associatedtype Fields
}

extension Result: Scoped where Success: Scoped {
	public typealias Fields = Success.Fields
}

extension Array: Scoped where Element: Scoped {
	public typealias Fields = Element.Fields
}
