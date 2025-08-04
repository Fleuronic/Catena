// Copyright © Fleuronic LLC. All rights reserved.

import Foundation

public enum AsyncIterationMode: Sendable {
	case serial
	case concurrent(priority: TaskPriority?, parallelism: Int)

	public static let concurrent = concurrent(priority: nil, parallelism: ProcessInfo.processInfo.processorCount)
}

public extension Sequence where Self: Sendable, Element: Sendable {
	func asyncMap<NewElement: Sendable>(
		mode: AsyncIterationMode = .concurrent,
		_ transform: @Sendable @escaping (Element) async throws -> NewElement
	) async rethrows -> [NewElement] {
		switch mode {

		case .serial:
			var result: [NewElement] = []
			result.reserveCapacity(underestimatedCount)
			for element in self {
				result.append(try await transform(element))
			}
			return result

		case let .concurrent(priority, parallelism):
			return try await withThrowingTaskGroup(of: (Int, NewElement).self) { group in
				var i = 0
				var iterator = self.makeIterator()
				var results = [NewElement?]()
				results.reserveCapacity(underestimatedCount)

				func submitTask() throws {
					try Task.checkCancellation()
					if let element = iterator.next() {
						results.append(nil)
						group.addTask(priority: priority) { [i] in (i, try await transform(element)) }
						i += 1
					}
				}

				// add initial tasks
				for _ in 0..<parallelism { try submitTask() }

				// submit more tasks, as each one completes, until we run out of work
				while let (index, result) = try await group.next() {
					results[index] = result
					try submitTask()
				}

				return results.compactMap { $0 }
			}
		}
	}
}
