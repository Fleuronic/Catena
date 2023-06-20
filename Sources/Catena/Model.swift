// Copyright © Fleuronic LLC. All rights reserved.

import Schemata
import PersistDB

public protocol Model: PersistDB.Model where ID: Decodable {
	var valueSet: ValueSet<Self> { get }
}

// MARK: -
public extension Model {
	var identifiedValueSet: ValueSet<Self> {
		valueSet.update(with: [Self.idKeyPath == id])
	}

	static var defaultOrder: [Ordering<Self>] {
		[.init(idKeyPath, ascending: true)]
	}
}
