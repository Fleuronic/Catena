// Copyright © Fleuronic LLC. All rights reserved.

import struct Schemata.None
import struct PersistDB.Query
import struct PersistDB.ValueSet
import struct PersistDB.Predicate
import protocol PersistDB.ModelProjection

public protocol Storage {
	func create<Model: Catena.Model>(_ model: Model) async -> Result<Model.ID, Never>
	func read<Projection: PersistDB.ModelProjection>(_ query: Query<None, Projection.Model>, returning: Projection.Type) async -> Result<[Projection], Never>
	func update<Projection: PersistDB.ModelProjection>(_ predicate: Predicate<Projection.Model>?, using valueSet: ValueSet<Projection.Model>, returning: Projection.Type) async -> Result<[Projection], Never>
	func delete<Model: Catena.Model>(_ type: Model.Type, with ids: [Model.ID]) async
}
