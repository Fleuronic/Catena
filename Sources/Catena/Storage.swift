// Copyright © Fleuronic LLC. All rights reserved.

import Schemata
import PersistDB

public protocol Storage {
	associatedtype StorageError: Error

	func insert<Model: Catena.Model>(_ model: Model) async -> Result<Model.ID, StorageError>
	func insert<Fields: Catena.Fields>(_ model: Fields.Model, returning fields: Fields.Type) async -> Result<Fields, StorageError>
	func insert<Model: Catena.Model>(_ models: [Model]) async -> Result<[Model.ID], StorageError>
	func insert<Fields: Catena.Fields>(_ models: [Fields.Model], returning fields: Fields.Type) async -> Result<[Fields], StorageError>
	func fetch<Model: Catena.Model>(_ type: Model.Type, where predicate: Predicate<Model>?) async -> Result<[Model.ID], StorageError>
	func fetch<Fields: Catena.Fields>(_ predicate: Predicate<Fields.Model>?, returning fields: Fields.Type) async -> Result<[Fields], StorageError>
	func update<Model: Catena.Model>(_ valueSet: ValueSet<Model>, where predicate: Predicate<Model>) async -> Result<[Model.ID], StorageError>
	func update<Fields: Catena.Fields>(_ valueSet: ValueSet<Fields.Model>, where predicate: Predicate<Fields.Model>, returning fields: Fields.Type) async -> Result<[Fields], StorageError>
	func update<Model: Catena.Model>(_ valueSet: ValueSet<Model>, with id: Model.ID) async -> Result<Model.ID, StorageError>
	func update<Fields: Catena.Fields>(_ valueSet: ValueSet<Fields.Model>, with id: Fields.Model.ID, returning fields: Fields.Type) async -> Result<Fields, StorageError>
	func delete<Model: Catena.Model>(_ type: Model.Type, where predicate: Predicate<Model>) async -> Result<Model.ID, StorageError>
	func delete<Fields: Catena.Fields>(_ type: Fields.Model.Type, where predicate: Predicate<Fields.Model>, returning fields: Fields.Type) async -> Result<Fields, StorageError>
	func delete<Model: Catena.Model>(_ type: Model.Type, with id: Model.ID) async -> Result<Model.ID, StorageError>
	func delete<Fields: Catena.Fields>(_ type: Fields.Model.Type, with id: Fields.Model.ID, returning fields: Fields.Type) async -> Result<Fields, StorageError>
}
