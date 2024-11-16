// Copyright © Fleuronic LLC. All rights reserved.

public protocol Scoped<Fields> {
	associatedtype Fields: Catena.Fields
}

extension Result: Scoped where Success: Scoped {
	public typealias Fields = Success.Fields
}

extension Array: Scoped where Element: Scoped {
	public typealias Fields = Element.Fields
}

extension Optional: Scoped where Wrapped: Scoped {
	public typealias Fields = Wrapped.Fields
}
