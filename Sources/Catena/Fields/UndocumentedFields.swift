// Copyright © Fleuronic LLC. All rights reserved.

public protocol UndocumentedFields: Fields {
	var undocumentedFields: [PartialKeyPath<Self>: Bool] { get }
}

public extension UndocumentedFields {
	var undocumentedFields: [PartialKeyPath<Self>: Bool] { [:] }
}
