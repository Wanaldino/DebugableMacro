//
//  VarVariable.swift
//  DebugableMacro
//
//  Created by Carlos Martinez on 14/12/24.
//

import SwiftSyntax

struct VarVariable: Variable {
    let name: String
    
    init(variable: VariableDeclSyntax) throws(DebugableVariableMacroError) {
        guard let name = variable.bindings.first?.pattern.as(IdentifierPatternSyntax.self)?.identifier.text else {
            throw DebugableVariableMacroError.nameNotFound
        }
        self.name = name
    }
    
    var body: [AccessorDeclSyntax] {
        return [AccessorDeclSyntax(
            accessorSpecifier: .keyword(.didSet),
            body: CodeBlockSyntax(statementsBuilder: {
                CodeBlockItemSyntax(stringLiteral: "print(\"OldValue: \\(oldValue). NewValue: \\(\(name))\"")
            })
        )]
    }
    var peer: [DeclSyntax] {
        []
    }
}
