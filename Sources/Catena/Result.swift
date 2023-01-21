// Copyright © Fleuronic LLC. All rights reserved.

public extension Result where Failure == Never {
	var value: Success {
		switch self {
		case let .success(value):
			return value
		}
	}
}
