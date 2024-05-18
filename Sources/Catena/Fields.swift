// Copyright © Fleuronic LLC. All rights reserved.

public protocol Fields: Scoped where Self.Fields == Self {
	associatedtype Model
}
