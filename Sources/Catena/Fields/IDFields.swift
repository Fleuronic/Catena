// Copyright © Fleuronic LLC. All rights reserved.

#if swift(<5.9)
import protocol Identity.Identifiable
#else
public import protocol Identity.Identifiable
#endif

public struct IDFields<Model: Identifiable & Sendable>: Fields, Hashable where Model.ID: Hashable & Sendable, Model.RawIdentifier: Sendable {
	public let id: Model.ID

	@Sendable public init(id: Model.ID) {
		self.id = id
	}
}
