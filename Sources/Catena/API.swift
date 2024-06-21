// Copyright © Fleuronic LLC. All rights reserved.

public protocol API: Sendable {
	associatedtype Error: Swift.Error & Equatable & CustomStringConvertible
}

// MARK: -
public extension API {
	typealias Result<T> = Swift.Result<T, Catena.Error<Error>>

	func result<Response>(request: @escaping () async throws -> Response) async -> Result<Response> {
		do {
			let response = try await request()
			return .success(response)
		} catch {
			return .failure(.init(error))
		}
	}
}
