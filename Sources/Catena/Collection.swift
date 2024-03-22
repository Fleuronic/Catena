// Copyright © Fleuronic LLC. All rights reserved.

@propertyWrapper
public struct Filled<T: Collection> {
	public var wrappedValue: T? {
		didSet {
			self.wrappedValue = wrappedValue?.filledValue
		}
	}

	public init(wrappedValue: T?) {
		self.wrappedValue = wrappedValue?.filledValue
	}
}

// MARK -
private extension Collection {
	var filledValue: Self? {
		isEmpty ? nil : self
	}
}
