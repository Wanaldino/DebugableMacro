//
//  DebugableFunctionMacro.swift
//  DebugableMacro
//
//  Created by Carlos Martinez on 13/12/24.
//

import SwiftSyntax
import SwiftSyntaxMacros

public struct DebugableFunctionMacro: BodyMacro {
    public static func expansion(
        of node: SwiftSyntax.AttributeSyntax,
        providingBodyFor declaration: some SwiftSyntax.DeclSyntaxProtocol & SwiftSyntax.WithOptionalCodeBlockSyntax,
        in context: some SwiftSyntaxMacros.MacroExpansionContext
    ) throws(DebugableFunctionError) -> [SwiftSyntax.CodeBlockItemSyntax] {
        guard let function = declaration.as(FunctionDeclSyntax.self) else {
            throw DebugableFunctionError.functionOnly
        }

        return WrappedFunction(function: function).body
    }
}

extension DebugableFunctionMacro: PeerMacro {
    public static func expansion(
        of node: SwiftSyntax.AttributeSyntax,
        providingPeersOf declaration: some SwiftSyntax.DeclSyntaxProtocol,
        in context: some SwiftSyntaxMacros.MacroExpansionContext
    ) throws -> [SwiftSyntax.DeclSyntax] {
        guard var function = declaration.as(FunctionDeclSyntax.self) else {
            throw DebugableFunctionError.functionOnly
        }

        function.name = WrappedFunctionName(function: function).syntaxName
        function.attributes = RemoveAttribute(name: "DebugableFunction", from: function.attributes).attributeListSyntax

        return [DeclSyntax(function)]
    }
}
