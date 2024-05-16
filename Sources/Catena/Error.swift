// Copyright © Fleuronic LLC. All rights reserved.

import class Foundation.NSError

public enum Error<Error: Swift.Error & CustomStringConvertible>: Swift.Error {
	case api(Error)
	case undocumented(String)
	case decoding(DecodingError)
	case network(NSError)
}

// MARK: -
public extension Error {
	init(_ error: Swift.Error) {
		if let error = error as? Error {
			self = .api(error)
		} else if let error = error as? DecodingError {
			self = .decoding(error)
		} else {
			self = .network(error as NSError)
		}
	}

	var message: String {
		switch self {
		case let .api(error): error.description
		case let .undocumented(message): message 
		case let .decoding(error): "\(error)"
		case let .network(error): error.localizedDescription
		}
	}
}
