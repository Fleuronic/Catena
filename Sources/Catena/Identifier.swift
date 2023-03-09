// Copyright © Fleuronic LLC. All rights reserved.

import Foundation
import Identity
import Schemata

extension Identifier: AnyModelValue where Value.RawIdentifier == UUID {}

// MARK: -
extension Identifier: ModelValue where Value.RawIdentifier == UUID {
	public static var value: Schemata.Value<String, Self> {
		UUID.value.bimap(
			decode: Self.init(rawValue:),
			encode: \.rawValue
		)
	}
}
