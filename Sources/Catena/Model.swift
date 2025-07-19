import Identity

public protocol Model: Hashable, Sendable {
	associatedtype ID: Hashable, Sendable

	var id: ID { get }
}

// MARK: -
public extension Model {
	// MARK: Hashable
	func hash(into hasher: inout Hasher) {
		hasher.combine(id)
	}

	// MARK: Equatable
	static func ==(lhs: Self, rhs: Self) -> Bool {
		lhs.id == rhs.id
	}
}
