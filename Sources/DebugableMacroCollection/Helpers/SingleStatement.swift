//
//  File.swift
//  DebugableMacro
//
//  Created by Carlos Martinez on 14/12/24.
//

import SwiftSyntax

struct ImplicitReturnStmt {
    var statements: CodeBlockItemListSyntax

    init(statements: CodeBlockItemListSyntax) {
        self.statements = if statements.count == 1, let statement = statements.first?.item.as(ExprSyntax.self) {
            CodeBlockItemListSyntax(
                arrayLiteral: CodeBlockItemSyntax(
                    item: CodeBlockItemSyntax.Item(
                        ReturnStmtSyntax(expression: statement)
                    )
                )
            )
        } else {
            statements
        }
    }
}
