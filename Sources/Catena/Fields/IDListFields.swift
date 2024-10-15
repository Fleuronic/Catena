// Copyright © Fleuronic LLC. All rights reserved.

public import protocol Identity.Identifiable

public struct IDListFields<Model: Identifiable & Sendable>: Fields, Sendable where Model.ID: Sendable {
	public let ids: [Model.ID]

	@Sendable public init(ids: [Model.ID]) {
		self.ids = ids
	}
}
