// Copyright © Fleuronic LLC. All rights reserved.

public protocol Scoped<Fields> {
	associatedtype Fields: Catena.Fields
}

// MARK: -
extension Result: Scoped where Success: Scoped {
	public typealias Fields = Success.Fields
}

// MARK: -
extension Array: Scoped where Element: Scoped {
	public typealias Fields = Element.Fields
}

// MARK: -
extension Optional: Scoped where Wrapped: Scoped {
	public typealias Fields = Wrapped.Fields
}
