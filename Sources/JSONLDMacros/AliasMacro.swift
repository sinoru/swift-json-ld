//
//  AliasMacro.swift
//  swift-json-ld
//
//  Created by Jaehong Kang on 11/18/24.
//

import SwiftSyntax
import SwiftSyntaxMacros

public struct AliasMacro: PeerMacro {
    public static func expansion(
        of node: AttributeSyntax,
        providingPeersOf declaration: some DeclSyntaxProtocol,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        // Does nothing, used only to decorate members with data
        return []
    }
}
