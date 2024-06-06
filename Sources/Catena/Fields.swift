// Copyright © Fleuronic LLC. All rights reserved.

public protocol Fields: Scoped where Self.Fields == Self {
	associatedtype Model
}

public protocol UndocumentedFields: Fields {
	var undocumentedFields: [PartialKeyPath<Self>: Bool] { get }
}

public extension UndocumentedFields {
	var undocumentedFields: [PartialKeyPath<Self>: Bool] { [:] }
}
