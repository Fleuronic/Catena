// Copyright © Fleuronic LLC. All rights reserved.

public protocol ResultProviding {
	associatedtype Error: Swift.Error

	typealias Results<Resource> = Result<[Resource], Error>
	typealias SingleResult<Resource> = Result<Resource, Error>
	typealias NoResult = Result<Void, Error>
}

// MARK: -
public extension Result {
	func `try`(_ action: (Success) async -> Void) async throws {
		switch self {
		case let .success(value): await action(value)
		case let .failure(error): throw error
		}
	}

	func map<NewSuccess>(_ transform: (Success) async -> NewSuccess) async -> Result<NewSuccess, Failure> {
		switch self {
		case let .success(value): await .success(transform(value))
		case let .failure(error): .failure(error)
		}
	}

	func flatMap<NewSuccess>(_ transform: (Success) async -> Result<NewSuccess, Failure>) async -> Result<NewSuccess, Failure> {
		switch self {
		case let .success(value): await transform(value)
		case let .failure(error): .failure(error)
		}
	}
}

public extension Result where Success: Nullable {
	func replaceNil(_ transform: () async -> Success.Wrapped) async -> Result<Success.Wrapped, Failure> {
		switch self {
		case let .success(value):
			if let wrapped = value.wrapped {
				.success(wrapped)
			} else {
				await .success(transform())
			}
		case let .failure(error):
			.failure(error)
		}
	}

	func replaceNil(_ transform: () async -> Result<Success.Wrapped, Failure>) async -> Result<Success.Wrapped, Failure> {
		switch self {
		case let .success(value):
			if let wrapped = value.wrapped {
				.success(wrapped)
			} else {
				await transform()
			}
		case let .failure(error):
			.failure(error)
		}
	}
}
