// Copyright © Fleuronic LLC. All rights reserved.

import Identity

public protocol Identifying<Identified> {
	associatedtype Identified: Identifiable
}

// MARK: -
extension Identifier: Identifying {
	public typealias Identified = Value
}

// MARK: -
public struct IDFields<Model: Identifiable & Sendable>: Fields, Hashable where Model.ID: Hashable & Sendable, Model.RawIdentifier: Sendable {
	public let id: Model.ID

	@Sendable public init(id: Model.ID) {
		self.id = id
	}
}

// MARK: -
public struct IDListFields<Model: Identifiable & Sendable>: Fields, Sendable where Model.ID: Sendable {
	public let ids: [Model.ID]

	@Sendable public init(ids: [Model.ID]) {
		self.ids = ids
	}
}

// MARK: -
extension Array: Identifying where Element: Identifying {
	public typealias Identified = Element.Identified
}
