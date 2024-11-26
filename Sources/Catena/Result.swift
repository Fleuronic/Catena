// Copyright © Fleuronic LLC. All rights reserved.

public protocol ResultProviding {
	associatedtype Error: Swift.Error

	typealias Results<Resource> = Result<[Resource], Error>
	typealias SingleResult<Resource> = Result<Resource, Error>
	typealias EmptyResult = Result<Void, Error>
	typealias ImpossibleResult = Result<Never, Error>
}

// MARK: -
public extension Result {
	func map<NewSuccess>(_ transform: (Success) async throws -> NewSuccess) async rethrows -> Result<NewSuccess, Failure> {
		switch self {
		case let .success(value): try await .success(transform(value))
		case let .failure(error): .failure(error)
		}
	}

	func flatMap<NewSuccess>(_ transform: (Success) async -> Result<NewSuccess, Failure>) async -> Result<NewSuccess, Failure> {
		switch self {
		case let .success(value): await transform(value)
		case let .failure(error): .failure(error)
		}
	}

	@discardableResult
	func tap(_ action: (Success) async -> Void) async throws -> Self {
		switch self {
		case let .success(value):
			await action(value)
			return self
		case let .failure(error):
			throw error
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
