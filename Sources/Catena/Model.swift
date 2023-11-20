// Copyright © Fleuronic LLC. All rights reserved.

import Schemata
import PersistDB

public protocol Model: PersistDB.Model where ID: Decodable {
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
