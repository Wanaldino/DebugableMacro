//
//  DebugableObjectMacro.swift
//  DebugableMacro
//
//  Created by Carlos Martinez on 13/12/24.
//

import SwiftSyntax
import SwiftSyntaxMacros

public struct DebugableVariableMacro {
    static func variable(for declaration: DeclSyntaxProtocol) throws(DebugableVariableMacroError) -> Variable {
        guard let variable = declaration.as(VariableDeclSyntax.self) else { throw DebugableVariableMacroError.variableOnly }

        guard let accessors = variable.bindings.first?.accessorBlock?.accessors else {
            return try SimpleVariable(variable: variable)
        }

        return switch accessors {
        case .accessors(let accessor): AccessorVariable(variable: variable)
        case .getter(let codeBlock): try ComputedVariable(variable: variable, accessors: codeBlock)
        }
    }
}

extension DebugableVariableMacro: AccessorMacro {
    public static func expansion(
        of node: SwiftSyntax.AttributeSyntax,
        providingAccessorsOf declaration: some SwiftSyntax.DeclSyntaxProtocol,
        in context: some SwiftSyntaxMacros.MacroExpansionContext
    ) throws(DebugableVariableMacroError) -> [SwiftSyntax.AccessorDeclSyntax] {
        try variable(for: declaration).body
    }
}

//extension DebugableVariableMacro: BodyMacro {
//    public static func expansion(
//        of node: AttributeSyntax,
//        providingBodyFor declaration: some DeclSyntaxProtocol & WithOptionalCodeBlockSyntax,
//        in context: some MacroExpansionContext
//    ) throws -> [CodeBlockItemSyntax] {
//        return []
//    }
//}

extension DebugableVariableMacro: PeerMacro {
    public static func expansion(
        of node: SwiftSyntax.AttributeSyntax,
        providingPeersOf declaration: some SwiftSyntax.DeclSyntaxProtocol,
        in context: some SwiftSyntaxMacros.MacroExpansionContext
    ) throws -> [SwiftSyntax.DeclSyntax] {
        try variable(for: declaration).peer
    }
}
