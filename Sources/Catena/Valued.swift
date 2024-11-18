// Copyright © Fleuronic LLC. All rights reserved.

public protocol Valued<Value>: Sendable {
	associatedtype Value = Self
}
