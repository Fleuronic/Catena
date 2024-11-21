// Copyright © Fleuronic LLC. All rights reserved.

public protocol Nullable {
	associatedtype Wrapped

	var wrapped: Wrapped? { get }
}

// MARK: -
extension Optional: Nullable {
	public var wrapped: Wrapped? { self }
}
