// Copyright © Fleuronic LLC. All rights reserved.

public extension Result {
	func asyncMap<T>(_ transform: (Success) async -> T) async -> Result<T, Failure> {
		switch self {
		case let .success(value):
			.success(await transform(value))
		case let .failure(error):
			.failure(error)
		}
	}

	func asyncFlatMap<T>(_ transform: (Success) async -> Result<T, Failure>) async -> Result<T, Failure> {
		switch self {
		case let .success(value):
			await transform(value)
		case let .failure(error):
			.failure(error)
		}
	}
}
