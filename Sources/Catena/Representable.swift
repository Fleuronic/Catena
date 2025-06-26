// Copyright © Fleuronic LLC. All rights reserved.

import Identity

public protocol Representable<Value, IdentifiedValue>: Valued {
	associatedtype IdentifiedValue: Identifiable

	var id: IdentifiedValue.ID { get }
	var value: Value { get }
}
