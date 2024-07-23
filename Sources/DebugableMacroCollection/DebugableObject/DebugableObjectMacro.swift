//
//  DebugableObjectMacro.swift
//  DebugableMacro
//
//  Created by Carlos Martinez on 13/12/24.
//

import SwiftSyntax
import SwiftSyntaxMacros

public struct DebugableObjectMacro: MemberAttributeMacro {
    public static func expansion(
        of node: SwiftSyntax.AttributeSyntax,
        attachedTo declaration: some SwiftSyntax.DeclGroupSyntax,
        providingAttributesFor member: some SwiftSyntax.DeclSyntaxProtocol,
        in context: some SwiftSyntaxMacros.MacroExpansionContext
    ) throws -> [SwiftSyntax.AttributeSyntax] {
        if member.is(FunctionDeclSyntax.self) {
            return ["@DebugableFunction"]
        } else if member.is(VariableDeclSyntax.self) {
            return ["@DebugableVariable"]
        } else {
            return []
        }
    }
}
