// Copyright © Fleuronic LLC. All rights reserved.

public enum Undocumented<Field: Sendable>: Sendable {
	case present(Field)
	case missing
}

public extension Undocumented {
	var precheckedValue: Field {
		switch self {
		case let .present(field): field
		default: fatalError()
		}
	}

	var isMissing: Bool {
		switch self {
		case .missing: true
		default: false
		}
	}
}

public extension Optional where Wrapped: Sendable {
	var undocumented: Undocumented<Wrapped> {
		map(Undocumented.present) ?? .missing
	}
}
