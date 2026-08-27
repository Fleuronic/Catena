// Copyright © Fleuronic LLC. All rights reserved.

import Foundation

public actor Gate {
	public static let shared = Gate()

	private let threshold: TimeInterval
	private let interval: TimeInterval
	private var lastRequest: Date?

	public init(
		threshold: TimeInterval = 0.25,
		interval: TimeInterval = 0.15
	) {
		self.threshold = threshold
		self.interval = interval
	}

	public func enter() async -> Bool {
		let now = Date()
		let isRapid = lastRequest.map { now.timeIntervalSince($0) < threshold } ?? false
		lastRequest = now

		guard isRapid else { return true }

		try? await Task.sleep(nanoseconds: UInt64(interval * 1_000_000_000))
		return !Task.isCancelled
	}
}
