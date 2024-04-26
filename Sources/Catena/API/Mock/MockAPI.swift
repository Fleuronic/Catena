// Copyright © Fleuronic LLC. All rights reserved.

import struct Foundation.TimeInterval
import class Foundation.JSONSerialization

public protocol MockAPI {
	func mockJSONObject(path: String, method: Request.Method) -> [String: Any]?
	func mockResource<Resource: Decodable, Error>(path: String, method: Request.Method) -> Result<Resource, Request.Error<Error>>?
}

// MARK: -
public extension MockAPI {
	func fakeActivity() async {
		let duration = TimeInterval.fakeActivityDuration
		try? await Task.sleep(nanoseconds: .init(duration * 1e9))
	}

	func mockJSONObject(path: String, method: String) -> [String: Any]? { nil }	
	func mockResource<Resource: Decodable, Error>(path: String, method: String) -> Result<Resource, Request.Error<Error>>? { nil }
}

// MARK: -
extension REST.API {
	func mockResource<Resource: Decodable>(path: String, method: Request.Method) async throws -> Result<Resource>? {
		guard let mockAPI = self as? MockAPI else { return nil }
		
		await mockAPI.fakeActivity()
		
		if let jsonObject = mockAPI.mockJSONObject(path: path, method: method) {
			let data = try JSONSerialization.data(withJSONObject: jsonObject, options: .fragmentsAllowed)
			return try .success(
				resource(
					data: data,
					response: nil
				)
			)
		}
		
		return mockAPI.mockResource(path: path, method: method)
	}
}

// MARK: -
private extension TimeInterval {
	static let fakeActivityDuration: Self = 1
}
