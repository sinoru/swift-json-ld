//
//  JSONDecoder.swift
//  swift-json-ld
//
//  Created by Jaehong Kang on 10/27/24.
//

extension KeyedDecodingContainerProtocol {
    @_disfavoredOverload
    @inlinable
    public func decode<D: Decodable>(_ type: D.Type = D.self, forKey key: Self.Key) throws -> D {
        if let type = type as? Bool.Type {
            return try unsafeBitCast(self.decode(type, forKey: key), to: D.self)
        } else if let type = type as? String.Type {
            return try unsafeBitCast(self.decode(type, forKey: key), to: D.self)
        } else if let type = type as? Double.Type {
            return try unsafeBitCast(self.decode(type, forKey: key), to: D.self)
        } else if let type = type as? Float.Type {
            return try unsafeBitCast(self.decode(type, forKey: key), to: D.self)
        } else if let type = type as? Int.Type {
            return try unsafeBitCast(self.decode(type, forKey: key), to: D.self)
        } else if let type = type as? Int8.Type {
            return try unsafeBitCast(self.decode(type, forKey: key), to: D.self)
        } else if let type = type as? Int16.Type {
            return try unsafeBitCast(self.decode(type, forKey: key), to: D.self)
        } else if let type = type as? Int32.Type {
            return try unsafeBitCast(self.decode(type, forKey: key), to: D.self)
        } else if let type = type as? Int64.Type {
            return try unsafeBitCast(self.decode(type, forKey: key), to: D.self)
        } else if #available(macOS 15.0, iOS 18.0, *), let type = type as? Int128.Type {
            return try unsafeBitCast(self.decode(type, forKey: key), to: D.self)
        } else if let type = type as? UInt.Type {
            return try unsafeBitCast(self.decode(type, forKey: key), to: D.self)
        } else if let type = type as? UInt8.Type {
            return try unsafeBitCast(self.decode(type, forKey: key), to: D.self)
        } else if let type = type as? UInt16.Type {
            return try unsafeBitCast(self.decode(type, forKey: key), to: D.self)
        } else if let type = type as? UInt32.Type {
            return try unsafeBitCast(self.decode(type, forKey: key), to: D.self)
        } else if let type = type as? UInt64.Type {
            return try unsafeBitCast(self.decode(type, forKey: key), to: D.self)
        } else if #available(macOS 15.0, iOS 18.0, *), let type = type as? UInt128.Type {
            return try unsafeBitCast(self.decode(type, forKey: key), to: D.self)
        } else {
            return try self.decode(type, forKey: key)
        }
    }

    @_disfavoredOverload
    @inlinable
    public func decode<D: Decodable>(_ type: Optional<D>.Type = Optional<D>.self, forKey key: Self.Key) throws -> D? {
        let unwrappedType = D.self

        if let type = unwrappedType as? Bool.Type {
            return try unsafeBitCast(self.decodeIfPresent(type, forKey: key), to: D.self)
        } else if let type = unwrappedType as? String.Type {
            return try unsafeBitCast(self.decodeIfPresent(type, forKey: key), to: D.self)
        } else if let type = unwrappedType as? Double.Type {
            return try unsafeBitCast(self.decodeIfPresent(type, forKey: key), to: D.self)
        } else if let type = unwrappedType as? Float.Type {
            return try unsafeBitCast(self.decodeIfPresent(type, forKey: key), to: D.self)
        } else if let type = unwrappedType as? Int.Type {
            return try unsafeBitCast(self.decodeIfPresent(type, forKey: key), to: D.self)
        } else if let type = unwrappedType as? Int8.Type {
            return try unsafeBitCast(self.decodeIfPresent(type, forKey: key), to: D.self)
        } else if let type = unwrappedType as? Int16.Type {
            return try unsafeBitCast(self.decodeIfPresent(type, forKey: key), to: D.self)
        } else if let type = unwrappedType as? Int32.Type {
            return try unsafeBitCast(self.decodeIfPresent(type, forKey: key), to: D.self)
        } else if let type = unwrappedType as? Int64.Type {
            return try unsafeBitCast(self.decodeIfPresent(type, forKey: key), to: D.self)
        } else if #available(macOS 15.0, iOS 18.0, *), let type = unwrappedType as? Int128.Type {
            return try unsafeBitCast(self.decodeIfPresent(type, forKey: key), to: D.self)
        } else if let type = unwrappedType as? UInt.Type {
            return try unsafeBitCast(self.decodeIfPresent(type, forKey: key), to: D.self)
        } else if let type = unwrappedType as? UInt8.Type {
            return try unsafeBitCast(self.decodeIfPresent(type, forKey: key), to: D.self)
        } else if let type = unwrappedType as? UInt16.Type {
            return try unsafeBitCast(self.decodeIfPresent(type, forKey: key), to: D.self)
        } else if let type = unwrappedType as? UInt32.Type {
            return try unsafeBitCast(self.decodeIfPresent(type, forKey: key), to: D.self)
        } else if let type = unwrappedType as? UInt64.Type {
            return try unsafeBitCast(self.decodeIfPresent(type, forKey: key), to: D.self)
        } else if #available(macOS 15.0, iOS 18.0, *), let type = unwrappedType as? UInt128.Type {
            return try unsafeBitCast(self.decodeIfPresent(type, forKey: key), to: D.self)
        } else {
            return try self.decodeIfPresent(unwrappedType, forKey: key)
        }
    }
}
