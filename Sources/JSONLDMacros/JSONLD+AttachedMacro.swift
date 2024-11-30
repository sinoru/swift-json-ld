//
//  JSONLD+AttachedMacro.swift
//  swift-json-ld
//
//  Created by Jaehong Kang on 10/27/24.
//

import SwiftSyntax
import SwiftSyntaxMacros

extension JSONLD: AttachedMacro {
    public static func expansion(
        of node: AttributeSyntax,
        providingBodyFor declaration: some DeclSyntaxProtocol & WithOptionalCodeBlockSyntax,
        in context: some MacroExpansionContext
    ) throws -> [CodeBlockItemSyntax] {
        let body: CodeBlockItemSyntax =
            """
            \(declaration.body)
            """

        return [body]
    }
}
