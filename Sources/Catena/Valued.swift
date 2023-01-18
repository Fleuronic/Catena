// Copyright © Fleuronic LLC. All rights reserved.

import struct PersistDB.ValueSet
import protocol PersistDB.Model

public protocol Valued {
	associatedtype Model: PersistDB.Model

	var valueSet: ValueSet<Model> { get }
}
