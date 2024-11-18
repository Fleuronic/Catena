// Copyright © Fleuronic LLC. All rights reserved.

import protocol Identity.Identifiable

public protocol Identifying<Model> {
	associatedtype Model: Identifiable
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
