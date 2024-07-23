//
//  AccessorVariable.swift
//  DebugableMacro
//
//  Created by Carlos Martinez on 14/12/24.
//

import SwiftSyntax

struct AccessorVariable: Variable {
    let variable: VariableDeclSyntax

    var body: [AccessorDeclSyntax] {
        []
    }
    var peer: [DeclSyntax] {
        []
    }
}
