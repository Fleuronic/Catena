// Copyright © Fleuronic LLC. All rights reserved.

public protocol Scoped {
	associatedtype ScopeFields: Fields
}

extension Result: Scoped where Success: Scoped {
	public typealias ScopeFields = Success.ScopeFields
}

extension Array: Scoped where Element: Scoped {
	public typealias ScopeFields = Element.ScopeFields
}
