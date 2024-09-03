// Copyright © Fleuronic LLC. All rights reserved.

import MemberwiseInit

import protocol Identity.Identifiable

@MemberwiseInit(.public)
public struct IDFields<Model: Identifiable & Sendable>: Fields, Hashable where Model.ID: Hashable & Sendable, Model.RawIdentifier: Sendable {
	public let id: Model.ID
}
