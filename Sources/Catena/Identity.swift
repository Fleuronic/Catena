// Copyright © Fleuronic LLC. All rights reserved.

import Identity
import Foundation

public extension Identifiable {
	typealias InvalidID = EmptyIdentifier<Self>
}

// MARK: -
public protocol Identifying<Identified> {
	associatedtype Identified: Identifiable
}

// MARK: -
extension Identifier: Identifying {
	public typealias Identified = Value
}

// MARK: -
public extension Identifier where Value.RawIdentifier == UUID {
	static var null: Self {
		.init(rawValue: .init(uuidString: "00000000-0000-0000-0000-000000000000")!)
	}

	static var random: Self {
		.init(rawValue: .init())
	}
}

// MARK: -
public enum EmptyIdentifier<Identified: Identifiable>: Identifying {}

// MARK: -
public enum EmptyIdentifiers<Identified: Identifiable>: Identifying {}

// MARK: -
public struct IDFields<Model: Identifiable & Sendable>: Fields, Hashable where Model.ID: Hashable & Sendable, Model.RawIdentifier: Sendable {
	public let id: Model.ID

	@Sendable public init(id: Model.ID) {
		self.id = id
	}
}

// MARK: -
public extension IDFields where Model.RawIdentifier == UUID {
	static var null: Self {
		.init(id: .null)
	}
}

// MARK: -
public struct IDListFields<Model: Identifiable & Sendable>: Fields, Sendable where Model.ID: Sendable {
	public let ids: [Model.ID]

	@Sendable public init(ids: [Model.ID]) {
		self.ids = ids
	}
}

// MARK: -
extension Array: Identifying where Element: Identifying {
	public typealias Identified = Element.Identified
}
