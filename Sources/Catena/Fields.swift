// Copyright © Fleuronic LLC. All rights reserved.

import Schemata
import PersistDB

public protocol Fields: Swift.Identifiable, Decodable, PersistDB.ModelProjection where Model: Catena.Model {
	static var toManyKeys: [PartialKeyPath<Model>: [String]] { get }
}

public extension Fields {
	static var toManyKeys: [PartialKeyPath<Model>: [String]] { [:] }
}

// MARK: -
public struct IDFields<Model: Catena.Model> {
	public let id: Model.ID
}

// MARK: -
extension IDFields: Decodable {}

extension IDFields: Fields {
	// MARK: ModelProjection
	public static var projection: Projection<Model, Self> {
		.init(
			Self.init,
			Model.idKeyPath
		)
	}
}
