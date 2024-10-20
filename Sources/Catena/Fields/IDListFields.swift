// Copyright © Fleuronic LLC. All rights reserved.

#if swift(<5.9)
import protocol Identity.Identifiable
#else
public import protocol Identity.Identifiable
#endif

public struct IDListFields<Model: Identifiable & Sendable>: Fields, Sendable where Model.ID: Sendable {
	public let ids: [Model.ID]

	@Sendable public init(ids: [Model.ID]) {
		self.ids = ids
	}
}
