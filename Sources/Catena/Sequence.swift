//
//  File.swift
//  
//
//  Created by Kay, Jordan (He/Him/His) on 6/16/23.
//

public extension Sequence {
    func asyncFlatMap<T, E>(
        _ transform: (Element) async -> Result<T, E>
    ) async -> Result<[T], E> {
        var values = [T]()
        
        for element in self {
            switch await transform(element) {
            case let .success(value):
                values.append(value)
            case let .failure(error):
                return .failure(error)
            }
        }
        
        return .success(values)
    }
}

