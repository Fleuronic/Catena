// Copyright © Fleuronic LLC. All rights reserved.

public extension Result {
    init(catching body: () async throws -> Success) async {
        do {
            self = .success(try await body())
        } catch let error as Failure {
            self = .failure(error)
        } catch {
            fatalError()
        }
    }
    
	func asyncMap<NewSuccess>(_ transform: (Success) async -> NewSuccess) async -> Result<NewSuccess, Failure> {
		switch self {
		case let .success(value):
			return .success(await transform(value))
		case let .failure(error):
			return .failure(error)
		}
	}

	func asyncFlatMap<NewSuccess>(_ transform: (Success) async -> Result<NewSuccess, Failure>) async -> Result<NewSuccess, Failure> {
		switch self {
		case let .success(value):
			return await transform(value)
		case let .failure(error):
			return .failure(error)
		}
	}
}
