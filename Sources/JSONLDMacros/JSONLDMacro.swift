//
//  JSONLDMacro.swift
//  swift-json-ld
//
//  Created by Jaehong Kang on 10/27/24.
//

#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

import SwiftSyntax
import SwiftSyntaxMacros

extension DeclModifierSyntax {
    var isAccessLevelModifier: Bool {
        switch self.name.tokenKind {
        case .keyword(.public),
                .keyword(.package),
                .keyword(.internal),
                .keyword(.private),
                .keyword(.fileprivate),
                .keyword(._spi),
                .keyword(._private):
            return true
        default:
            return false
        }
    }
}

struct JSONLDMacro: ExtensionMacro {
    public static func expansion(
        of node: SwiftSyntax.AttributeSyntax,
        attachedTo declaration: some SwiftSyntax.DeclGroupSyntax,
        providingExtensionsOf type: some SwiftSyntax.TypeSyntaxProtocol,
        conformingTo protocols: [SwiftSyntax.TypeSyntax],
        in context: some SwiftSyntaxMacros.MacroExpansionContext
    ) throws -> [SwiftSyntax.ExtensionDeclSyntax] {
        guard
            case .argumentList(let arguments) = node.arguments,
            arguments.count == 1,
            let contextArgument = arguments.first(where: { $0.label?.text == "context" })?.expression.as(StringLiteralExprSyntax.self)?.segments,
            let context = URL(string: contextArgument.description)
        else {
          throw Error.message(#"@JSONLDType requires `context` as an argument."#)
        }

        let accessModifiers = declaration.modifiers.filter(\.isAccessLevelModifier)

        let memberList = declaration.memberBlock.members

        let codingKeys: [String: String?] = Dictionary(
            uniqueKeysWithValues:
                memberList
                    .lazy
                    .compactMap { member in
                        guard
                            let propertyName = member
                                .decl.as(VariableDeclSyntax.self)?
                                .bindings.first?
                                .pattern.as(IdentifierPatternSyntax.self)?.identifier.text
                        else {
                            return nil
                        }

                        let aliasMacro = member.decl.as(VariableDeclSyntax.self)?.attributes.first(where: { element in
                            element.as(AttributeSyntax.self)?.attributeName.as(IdentifierTypeSyntax.self)?.description == "Alias"
                        })

                        let aliasName = aliasMacro?.as(AttributeSyntax.self)?
                            .arguments?.as(LabeledExprListSyntax.self)?
                            .first(where: { $0.label?.text == "name" })?
                            .expression.as(StringLiteralExprSyntax.self)?.segments.description

                        switch (propertyName, aliasName) {
                        case (let propertyName, let aliasName?):
                            return (propertyName, aliasName)
                        case ("id", nil):
                            return (propertyName, "@id")
                        case (let propertyName, nil):
                            return (propertyName, nil)

                        }
                    }
        )

        let codingKeysSyntax: DeclSyntax = """
        private enum CodingKeys: String, CodingKey {
            case context = "@context"
            \(raw: codingKeys.lazy.map { (propertyName, codingKey) in "case \(propertyName)" + (codingKey.flatMap { #" = "\#($0)""# } ?? "") }.joined(separator: "\n"))
        }
        """

        let decodings: [String] = codingKeys
            .map {
                "\($0.0) = try container.decode(forKey: .\($0.0))"
            }

        let encodingSyntax: DeclSyntax = #"""
        \#(accessModifiers) func encode(to encoder: any Encoder) throws {
            var container = try encoder.container(keyedBy: CodingKeys.self)
        
            \#(raw: codingKeys.map { "try container.encode(\($0.0), forKey: .\($0.0))" }.joined(separator: "\n"))
        }
        """#

        let codableExtension: DeclSyntax =
            #"""
            extension \#(type.trimmed): Codable {
                \#(accessModifiers) static let context = URL(string: "\#(raw: context.absoluteString)")!
            
                \#(codingKeysSyntax)
                
                \#(accessModifiers) init(from decoder: any Decoder) throws {
                    let container = try decoder.container(keyedBy: CodingKeys.self)
            
                    let context = try container.decode(URL.self, forKey: .context)
                    guard context == Self.context else {
                        throw DecodingError.dataCorrupted(
                            .init(
                                codingPath: decoder.codingPath,
                                debugDescription: "Decoder expects context \(Self.context), but it has \(context)",
                                underlyingError: nil
                            )
                        )
                    }

                    \#(raw: decodings.joined(separator: "\n"))
                }

                \#(encodingSyntax)
            }
            """#

        guard let extensionDecl = codableExtension.as(ExtensionDeclSyntax.self) else {
            return []
        }

        return [extensionDecl]
    }
}
