//
//  JSONLDDecoder.swift
//  swift-json-ld
//
//  Created by Jaehong Kang on 11/18/24.
//

import Foundation
import JSONValueCoder

public struct JSONLDDecoder {
    private let jsonDecoder: JSONDecoder
    private let jsonValueDecoder: JSON.ValueDecoder

    public init(jsonDecoder: JSONDecoder = JSONDecoder()) {
        self.jsonDecoder = jsonDecoder
        self.jsonValueDecoder = JSON.ValueDecoder()
    }

    public func decode<T, D: ContiguousBytes>(
        _ type: T.Type,
        from data: D
    ) throws -> T where T : Decodable {
        let jsonValue = try data.withUnsafeBytes { buffer in
            let unsafeData = Data(bytesNoCopy: UnsafeMutableRawPointer(mutating: buffer.baseAddress)!, count: buffer.count, deallocator: .none)

            return try jsonDecoder.decode(JSON.Value.self, from: unsafeData)
        }

        switch jsonValue {
        case .object(let jsonLDObject):
            return try jsonValueDecoder.decode(type, from: .object(expansion(jsonLDObject)))
        case .array, .string, .number, .bool:
            // TODO: Error handling
            throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: ""))
        case .null:
            // TODO: Error handling
            throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: ""))
        }

    }
}

extension JSONLDDecoder {
    public func expansion(_ jsonLDObject: JSON.Object) throws -> JSON.Object {
        guard let context = jsonLDObject["@context"] else {
            // TODO: Error handling
            throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: ""))
        }

        // TODO: Expansion

        return jsonLDObject
    }
}
