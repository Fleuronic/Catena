// Copyright © Fleuronic LLC. All rights reserved.

public protocol Fields: Scoped, Sendable where Self.Fields == Self {
	associatedtype Model
}

// MARK: -
public struct ImpossibleFields<Model>: Fields {}
