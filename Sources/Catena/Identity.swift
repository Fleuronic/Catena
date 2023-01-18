// Copyright © Fleuronic LLC. All rights reserved.

import struct Foundation.UUID
import struct Schemata.Value
import protocol Schemata.ModelValue
import protocol Schemata.AnyModelValue
import protocol Identity.Identifiable
import struct Identity.Identifier

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
