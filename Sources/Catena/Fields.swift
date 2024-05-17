// Copyright © Fleuronic LLC. All rights reserved.

public protocol Fields {
	associatedtype Model
}

// MARK: -
extension Result: Fields {
	public typealias Model = Success
}
