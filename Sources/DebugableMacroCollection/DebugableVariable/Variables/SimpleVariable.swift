//
//  SimpleVariable.swift
//  DebugableMacro
//
//  Created by Carlos Martinez on 14/12/24.
//

import SwiftSyntax

struct SimpleVariable: Variable {
    let variable: Variable

    init(variable: VariableDeclSyntax) throws(DebugableVariableMacroError) {
        switch variable.bindingSpecifier.tokenKind {
        case .keyword(let keyword) where keyword == .let: self.variable = LetVariable()
        case .keyword(let keyword) where keyword == .var: try self.variable = VarVariable(variable: variable)
        default: throw DebugableVariableMacroError.variableNotIdentified
        }
    }

    var body: [AccessorDeclSyntax] {
        variable.body
    }
    var peer: [DeclSyntax] {
        variable.peer
    }
}
