// Copyright © Fleuronic LLC. All rights reserved.

import Foundation

public actor Gate {
	public static let shared = Gate()

	private var lastRequest: Date?


	public func enter() async -> Bool {
		let now = Date()
		let isRapid = lastRequest.map { now.timeIntervalSince($0) < 0.1 } ?? false
		lastRequest = now

		guard isRapid else { return true }

		try? await Task.sleep(nanoseconds: UInt64(0.1 * 1_000_000_000))
		return !Task.isCancelled
	}
}
