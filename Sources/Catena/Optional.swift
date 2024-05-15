// Copyright © Fleuronic LLC. All rights reserved.

public protocol OptionalProtocol {
	associatedtype Wrapped

	var wrapped: Wrapped? { get }
}

extension Optional: OptionalProtocol {
	public var wrapped: Wrapped? { self }
}
