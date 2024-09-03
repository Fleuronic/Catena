// Copyright © Fleuronic LLC. All rights reserved.

import MemberwiseInit

import protocol Identity.Identifiable

@MemberwiseInit(.public)
public struct IDListFields<Model: Identifiable & Sendable>: Fields, Sendable where Model.ID: Sendable {
	public let ids: [Model.ID]
}
