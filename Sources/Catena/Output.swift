// Copyright © Fleuronic LLC. All rights reserved.

public protocol Output<Success>: Sendable {
	associatedtype Success
	associatedtype Failure: Error

	var results: Results { get }
}

// MARK: -
public extension Output {
	typealias Results = AsyncStream<Result<Success, Failure>>
}

// MARK: -
extension Result: Output {}

extension Result where Success: Sendable {
	// MARK: Output
	public var results: Results {
		.init { continuation in
			continuation.yield(self)
			continuation.finish()
		}
	}
}
