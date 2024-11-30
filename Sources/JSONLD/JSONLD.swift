// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

@attached(extension, conformances: Codable, names: named(CodingKeys), named(context), named(init(from:)), named(encode(to:)))
public macro JSONLD(context: String) = #externalMacro(module: "JSONLDMacros", type: "JSONLDMacro")

@attached(peer)
public macro Alias(name: String) = #externalMacro(module: "JSONLDMacros", type: "AliasMacro")
