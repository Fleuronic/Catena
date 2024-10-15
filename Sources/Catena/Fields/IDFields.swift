// Copyright © Fleuronic LLC. All rights reserved.

public import protocol Identity.Identifiable

public struct IDFields<Model: Identifiable & Sendable>: Fields, Hashable where Model.ID: Hashable & Sendable, Model.RawIdentifier: Sendable {
	public let id: Model.ID

	@Sendable public init(id: Model.ID) {
		self.id = id
	}
}
