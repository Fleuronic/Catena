// Copyright © Fleuronic LLC. All rights reserved.

public protocol Fields: Scoped where ScopeFields == Self {
	associatedtype Model
}
