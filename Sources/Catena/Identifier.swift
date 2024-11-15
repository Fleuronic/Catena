// Copyright © Fleuronic LLC. All rights reserved.

import protocol Identity.Identifiable

public protocol Identifying<Model> {
	associatedtype Model: Identifiable
}
