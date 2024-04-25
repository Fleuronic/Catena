// Copyright © Fleuronic LLC. All rights reserved.

public extension Optional {
	func asyncMap<T>(transform: (Wrapped) async -> T) async -> T? {
		if let result = self { await transform(result) } else { nil }
	}

	func asyncFlatMap<T>(transform: (Wrapped) async -> T?) async -> T? {
		if let result = self { await transform(result) } else { nil }
	}

	func asyncMapNil(defaultValue: () async -> Wrapped) async -> Wrapped {
		if let result = self { result } else { await defaultValue() }
	}
}
