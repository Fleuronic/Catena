// Copyright © Fleuronic LLC. All rights reserved.

public extension Sequence {
	func asyncMap<T>(_ transform: (Element) async throws -> T) async rethrows -> [T] {
		var values = [T]()
		
		for element in self {
			try await values.append(transform(element))
		}
		
		return values
	}

	func asyncFlatMap<T, E>(_ transform: (Element) async -> Result<T, E>) async -> Result<[T], E> {
		var values = [T]()
		
		for element in self {
			switch await transform(element) {
			case let .success(value):
				values.append(value)
			case let .failure(error):
				return .failure(error)
			}
		}
		
		return .success(values)
	}
}
