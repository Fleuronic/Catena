// Copyright © Fleuronic LLC. All rights reserved.

import protocol Identity.Identifiable

public protocol Representable<Value, IdentifiedValue>: Valued {
	associatedtype IdentifiedValue: Identity.Identifiable

	var id: IdentifiedValue.ID { get }
	var value: Value { get }
}
