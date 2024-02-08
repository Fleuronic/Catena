// Copyright © Fleuronic LLC. All rights reserved.

import PersistDB

import protocol Identity.Identifiable

public protocol Model: PersistDB.Model, Identity.Identifiable {
	var valueSet: ValueSet<Self> { get }

	static var queryName: String { get }
}

// MARK: -
public extension Model {
	var identifiedValueSet: ValueSet<Self> {
		valueSet.update(with: [Self.idKeyPath == id])
	}

	static var defaultOrder: [Ordering<Self>] {
		[.init(idKeyPath, ascending: true)]
	}

	// MARK: Model
	static var queryName: String {
		.init(schema.name.dropLast())
	}
}
