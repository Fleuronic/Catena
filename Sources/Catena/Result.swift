// Copyright © Fleuronic LLC. All rights reserved.

public protocol ResultProviding {
	associatedtype Error: Swift.Error

	typealias Results<Resource> = Result<[Resource], Error>
	typealias SingleResult<Resource> = Result<Resource, Error>
	typealias ImpossibleResult = Never
	typealias NoResult = Result<Void, Error>
}

public extension Result {
	func map<NewSuccess>(_ transform: (Success) async -> NewSuccess) async -> Result<NewSuccess, Failure> {
		switch self {
		case let .success(value): return .success(await transform(value))
		case let .failure(error): return .failure(error)
		}
	}

	func flatMap<NewSuccess>(_ transform: (Success) async -> Result<NewSuccess, Failure>) async -> Result<NewSuccess, Failure> {
		switch self {
		case let .success(value): return await transform(value)
		case let .failure(error): return .failure(error)
		}
	}
}
