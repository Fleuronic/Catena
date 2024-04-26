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
	func getResource(atPath path: PathComponent..., with parameters: some Parameters = EmptyParameters()) async -> Result<Void> {
		let result: Result<EmptyResource> = await resource(
			path: path,
			method: .get,
			parameters: parameters,
			payload: EmptyPayload()
		)
		
		return result.map { _ in }
	}

	func getResource<Resource: Decodable>(at path: PathComponent..., with parameters: some Parameters = EmptyParameters()) async -> Result<Resource> {
		await resource(
			path: path,
			method: .get,
			parameters: parameters,
			payload: EmptyPayload()
		)
	}

	func post(_ payload: some Payload, to path: PathComponent..., with parameters: some Parameters = EmptyParameters()) async -> Result<Void> {
		let result: Result<EmptyResource> = await self.resource(
			path: path,
			method: .post,
			parameters: parameters,
			payload: payload
		)
		
		return result.map { _ in }
	}

	func post<Resource: Decodable>(_ payload: some Payload, to path: PathComponent..., with parameters: some Parameters = EmptyParameters()) async -> Result<Resource> {
		await self.resource(
			path: path,
			method: .post,
			parameters: parameters,
			payload: payload
		)
	}

	func put(_ payload: some Payload = EmptyPayload(), at path: PathComponent..., with parameters: some Parameters = EmptyParameters()) async -> Result<Void> {
		let result: Result<EmptyResource> = await resource(
			path: path,
			method: .put,
			parameters: parameters,
			payload: payload
		)
		
		return result.map { _ in }
	}

	func put<Resource: Decodable>(_ payload: some Payload = EmptyPayload(), at path: PathComponent..., with parameters: some Parameters = EmptyParameters()) async -> Result<Resource> {
		await resource(
			path: path,
			method: .put,
			parameters: parameters,
			payload: payload
		)
	}

	func deleteResource(at path: PathComponent..., using payload: some Payload = EmptyPayload(), with parameters: some Parameters = EmptyParameters()) async -> Result<Void> {
		let result: Result<EmptyResource> = await resource(
			path: path,
			method: .delete,
			parameters: parameters,
			payload: payload
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
		path: [PathComponent],
		method: Request.Method,
		parameters: some Parameters,
		payload: some Payload
	) async -> Result<Resource> {
		do {
			let path = path.map(\.rawValue).joined(separator: "/")
			if let resource: Result<Resource> = try await mockResource(path: path, method: method) {
				return resource
			}

			let (data, urlResponse) = try await URLSession.shared.data(
				for: urlRequest(
					method: method,
					body: payload.data(using: encoder),
					components: try components(
						url: url(for: path),
						parameters: parameters
					)
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
		parameters: some Parameters
	) throws -> URLComponents {
		let queryItems = try parameters.queryItems
		var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!

		if !queryItems.isEmpty { components.queryItems = queryItems }
		return components
	}

	func urlRequest(
		method: Request.Method,
		body: Data?,
		components: URLComponents
	) -> URLRequest {
		var urlRequest = URLRequest(url: components.url!)
		urlRequest.httpMethod = method.value
		urlRequest.httpBody = body
		
		authenticationHeader.map { urlRequest.apply($0) }
		body.map { _ in urlRequest.apply(.jsonContentType) }
		return urlRequest
	}
}

// MARK: -
private struct EmptyResource: Decodable {}
