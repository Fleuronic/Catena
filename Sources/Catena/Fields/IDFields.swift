// Copyright © Fleuronic LLC. All rights reserved.

import InitMacro

import protocol Identity.Identifiable

@Init public struct IDFields<Model: Identifiable>: Fields, Hashable where Model.ID: Hashable & Sendable, Model.RawIdentifier: Sendable {
	public let id: Model.ID
}
