// Copyright © Fleuronic LLC. All rights reserved.

public extension Optional {
    func asyncMapNil(defaultValue: () async throws -> Wrapped) async rethrows -> Wrapped {
        if let result = self {
            return result
        } else {
            return try await defaultValue()
        }
    }
}
