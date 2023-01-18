// Copyright © Fleuronic LLC. All rights reserved.

import Schemata
import PersistDB

public protocol Model: PersistDB.Model, Valued where Self == Model {
	static var idKeyPath: KeyPath<Self, ID> { get }
	static var tableName: String { get }
}

public extension Model {
	var identifiedValueSet: ValueSet<Self> {
		valueSet.update(with: [Self.idKeyPath == id])
	}

	static var idProperty: Property<Self, ID> {
		idKeyPath ~ "id"
	}

	static var defaultOrder: [Ordering<Self>] {
		[.init(idKeyPath, ascending: true)]
	}
}
