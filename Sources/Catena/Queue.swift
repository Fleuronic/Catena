// Copyright © Fleuronic LLC. All rights reserved.

public actor Queue {
	public static let shared = Queue()

	private var tail: Task<Void, Never>?

	public init() {}

	public func enqueue(_ work: @escaping @Sendable () async -> Void) {
		let previous = tail
		tail = Task {
			await previous?.value
			await work()
		}
	}
}
