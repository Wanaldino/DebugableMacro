//
//  LetVariable.swift
//  DebugableMacro
//
//  Created by Carlos Martinez on 14/12/24.
//

import SwiftSyntax

struct LetVariable: Variable {
    var body: [AccessorDeclSyntax] { [] }
    var peer: [DeclSyntax] { [] }
}
