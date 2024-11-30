//
//  JSONLDMacros.swift
//  swift-json-ld
//
//  Created by Jaehong Kang on 10/27/24.
//

import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct JSONLDMacros: CompilerPlugin {
    var providingMacros: [Macro.Type] = [JSONLDMacro.self, AliasMacro.self]
}
