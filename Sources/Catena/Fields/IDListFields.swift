// Copyright © Fleuronic LLC. All rights reserved.

import InitMacro

import protocol Identity.Identifiable

@Init public struct IDListFields<Model: Identifiable>: Fields where Model.ID: Sendable {
	public let ids: [Model.ID]
}
