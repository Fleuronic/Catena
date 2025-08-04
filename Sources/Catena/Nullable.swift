// Copyright © Fleuronic LLC. All rights reserved.

public protocol Nullable {
	associatedtype Wrapped

	var wrapped: Wrapped? { get }
}

public extension Optional {
	func asyncMap<T>(_ transform: (Wrapped) async throws -> T) async rethrows -> T? {
		if let value = self {
			try await transform(value)
		} else {
			nil
		}
	}
}

// MARK: -
extension Optional: Nullable {
	public var wrapped: Wrapped? { self }
}
