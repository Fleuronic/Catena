// Copyright © Fleuronic LLC. All rights reserved.

public extension Optional {
    func asyncMap<T>(transform: (Wrapped) async -> T) async -> T? {
        if let result = self {
            return await transform(result)
        }
        return nil
    }

    func asyncMapNil(defaultValue: () async -> Wrapped) async -> Wrapped {
        if let result = self {
            return result
        }
        return await defaultValue()
    }
}
