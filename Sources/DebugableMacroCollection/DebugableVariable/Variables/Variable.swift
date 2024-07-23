//
//  Variable.swift
//  DebugableMacro
//
//  Created by Carlos Martinez on 14/12/24.
//

import SwiftSyntax

protocol Variable {
    var body: [AccessorDeclSyntax] { get }
    var peer: [DeclSyntax] { get }
}
