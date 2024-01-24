// Copyright © Fleuronic LLC. All rights reserved.

import Schemata
import PersistDB

public protocol Storage {
	associatedtype StorageError: Error

	func insert<Model: Catena.Model>(_ model: Model) async -> Result<Model.ID, StorageError>
	func insert<Model: Catena.Model>(_ models: [Model]) async -> Result<[Model.ID], StorageError>
	func fetch<Model: Catena.Model>(where predicate: Predicate<Model>?) async -> Result<[Model.ID], StorageError>
	func fetch<Fields: Catena.Fields>(_ fields: Fields.Type, where: Predicate<Fields.Model>?) async -> Result<[Fields], StorageError>
	func update<Model: Catena.Model>(_ valueSet: ValueSet<Model>, with id: Model.ID) async -> Result<Model.ID, StorageError>
	func update<Model: Catena.Model>(_ valueSet: ValueSet<Model>, where predicate: Predicate<Model>?) async -> Result<[Model.ID], StorageError>
	func delete<Model: Catena.Model>(_ type: Model.Type, with id: Model.ID) async -> Result<Model.ID?, StorageError>
	func delete<Model: Catena.Model>(_ type: Model.Type, with ids: [Model.ID]) async -> Result<[Model.ID], StorageError>
	func delete<Model: Catena.Model>(_ type: Model.Type, where predicate: Predicate<Model>?) async -> Result<[Model.ID], StorageError>
}

// MARK: -
public extension Storage {
	func fetch<Fields: Catena.Fields>(_ fields: Fields.Type, with id: Fields.Model.ID) async -> Result<Fields?, StorageError> {
		await fetch(fields, where: Fields.Model.idKeyPath == id).map(\.first)
	}
}
