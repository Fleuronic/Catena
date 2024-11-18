// Copyright © Fleuronic LLC. All rights reserved.

public protocol Nullable {
	associatedtype Wrapped

	var wrapped: Wrapped? { get }
}

extension Optional: Nullable {
	public var wrapped: Wrapped? { self }
}
