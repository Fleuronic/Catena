// Copyright © Fleuronic LLC. All rights reserved.

import MultipartFormData

import struct Foundation.Data
import struct Foundation.URL
import struct Foundation.URLRequest
import struct Foundation.URLComponents
import class Foundation.URLSession
import class Foundation.NSError
import class Foundation.HTTPURLResponse

public extension REST {
	protocol API: Catena.API {}
}

// MARK: -
public extension REST.API {
	func get(
		_ path: PathComponent?..., 
		parameters: () -> Parameters? = { nil }
	) async -> Result<Void> {
		let result: Result<EmptyResource> = await resource(
			path: path,
			method: .get,
			parameters: parameters()
		)

		return result.map { _ in }
	}

	func get<Resource: Decodable>(
		_ path: PathComponent?..., 
		parameters: () -> Parameters? = { nil }
	) async -> Result<Resource> {
		await resource(
			path: path,
			method: .get,
			parameters: parameters()
		)
	}

	func post(
		_ path: PathComponent?...,
		payload: () -> Payload?, 
		parameters: () -> Parameters? = { nil }
	) async -> Result<Void> {
		let result: Result<EmptyResource> = await self.resource(
			path: path,
			method: .post,
			parameters: parameters(),
			payload: payload()
		)

		return result.map { _ in }
	}

	func post<Resource: Decodable>(
		_ path: PathComponent?..., 
		payload: () -> Payload?, 
		parameters: () -> Parameters? = { nil }
	) async -> Result<Resource> {
		await self.resource(
			path: path,
			method: .post,
			parameters: parameters(),
			payload: payload()
		)
	}

	func put(
		_ path: PathComponent?...,
		payload: () -> Payload? = { nil }, 
		parameters: () -> Parameters? = { nil }
	) async -> Result<Void> {
		let result: Result<EmptyResource> = await resource(
			path: path,
			method: .put,
			parameters: parameters(),
			payload: payload()
		)

		return result.map { _ in }
	}

	func put<Resource: Decodable>(
		_ path: PathComponent?...,
		payload: () -> Payload? = { nil }, 
		parameters: () -> Parameters? = { nil }
	) async -> Result<Resource> {
		await resource(
			path: path,
			method: .put,
			parameters: parameters(),
			payload: payload()
		)
	}

	func delete(
		_ path: PathComponent?...,
		payload: () -> Payload? = { nil }, 
		parameters: () -> Parameters? = { nil }
	) async -> Result<Void> {
		let result: Result<EmptyResource> = await resource(
			path: path,
			method: .delete,
			parameters: parameters(),
			payload: payload()
		)
		
		return result.map { _ in }
	}
}

// MARK: -
extension REST.API {
	func resource<Resource: Decodable>(
		data: Data,
		response: HTTPURLResponse?
	) throws -> Resource {
		try
			response?.url as? Resource ??
			data as? Resource ??
			decoder.decode(Response.self, from: data).resource()
	}
}

// MARK: -
private extension REST.API {
	func resource<Resource: Decodable>(
		path: [PathComponent?],
		method: Request.Method,
		parameters: Parameters?,
		payload: Payload? = nil,
		upload: Upload? = nil
	) async -> Result<Resource> {
		do {
			let path = path.compactMap(\.?.rawValue).joined(separator: "/")
			if let resource: Result<Resource> = try await mockResource(path: path, method: method) {
				return resource
			}

			let (data, urlResponse) = try await URLSession.shared.data(
				for: urlRequest(
					method: method,
					url: try components(
						url: url(for: path),
						parameters: parameters
					).url!,
					payload: payload,
					upload: upload
				)
			)

			return try .success(
				resource(
					data: data,
					response: urlResponse as? HTTPURLResponse
				)
			)
		} catch let error as Error {
			return .failure(.api(error))
		} catch let error as DecodingError {
			return .failure(.decoding(error))
		} catch let error as NSError {
			return .failure(.network(error))
		}
	}

	func components(
		url: URL,
		parameters: Parameters?
	) throws -> URLComponents {
		var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
		components.queryItems = try parameters?.queryItems
		return components
	}

	func urlRequest(
		method: Request.Method,
		url: URL,
		payload: Payload?,
		upload: Upload?
	) -> URLRequest {
		var urlRequest = URLRequest(url: url)

		let body = payload?.data(using: encoder)
		urlRequest.httpMethod = method.value
		urlRequest.httpBody = body

		authenticationHeader.map { urlRequest.apply($0) }
		body.map { _ in urlRequest.apply(.jsonContentType) }
		return urlRequest
	}
}

// MARK: -
private struct EmptyResource: Decodable {}
