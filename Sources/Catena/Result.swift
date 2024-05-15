// Copyright © Fleuronic LLC. All rights reserved.

public extension Result {
	func asyncMap<NewSuccess>(_ transform: (Success) async -> NewSuccess) async -> Result<NewSuccess, Failure> {
		switch self {
		case let .success(value): .success(await transform(value))
		case let .failure(error): .failure(error)
		}
	}

	func asyncFlatMap<NewSuccess>(_ transform: (Success) async -> Result<NewSuccess, Failure>) async -> Result<NewSuccess, Failure> {
		switch self {
		case let .success(value): await transform(value)
		case let .failure(error): .failure(error)
		}
	}
}

// MARK: -
public extension Result where Success: OptionalProtocol {
	func map<NewSuccess>(_ transform: (Success.Wrapped) -> NewSuccess) async -> Result<NewSuccess?, Failure> {
		switch self {
		case let .success(value):
			if let wrapped = value.wrapped {
				.success(transform(wrapped) as NewSuccess?)
			} else {
				.success(nil)
			}
		case let .failure(error):
			.failure(error)
		}
	}

	func asyncFlatMap<NewSuccess>(_ transform: (Success.Wrapped) async -> Result<NewSuccess, Failure>) async -> Result<NewSuccess?, Failure> {
		switch self {
		case let .success(value):
			if let wrapped = value.wrapped {
				await transform(wrapped).map { $0 as NewSuccess? }
			} else {
				.success(nil)
			}
		case let .failure(error): 
			.failure(error)
		}
	}
}
