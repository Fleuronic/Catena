// Copyright © Fleuronic LLC. All rights reserved.

import PersistDB

import protocol Identity.Identifiable

public protocol Model: PersistDB.Model, Identity.Identifiable where ID: Decodable {
	var valueSet: ValueSet<Self> { get }

	static var queryName: String { get }
}

// MARK: -
public extension Model {
	// MARK: Model
	static var queryName: String {
		.init(schema.name.dropLast())
	}
}
