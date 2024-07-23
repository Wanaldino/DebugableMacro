//
//  DeferStatement.swift
//  DebugableMacro
//
//  Created by Carlos Martinez on 14/12/24.
//

import SwiftSyntax

struct DeferStatement {
    var statement: CodeBlockItemSyntax {
//        let definition = """
//        defer {
//            print("Defer: \\(#function) exited")
//        }
//        """
//        return CodeBlockItemSyntax(stringLiteral: definition)
        return CodeBlockItemSyntax(
            item: CodeBlockItemSyntax.Item.stmt(
                StmtSyntax(
                    DeferStmtSyntax(
                        body: CodeBlockSyntax(
                            statements: CodeBlockItemListSyntax(
                                itemsBuilder: {
                                    CodeBlockItemSyntax(
                                        item: CodeBlockItemSyntax.Item.expr(
                                            ExprSyntax(
                                                FunctionCallExprSyntax(
                                                    calledExpression: ExprSyntax(stringLiteral: "print"),
                                                    leftParen: .leftParenToken(),
                                                    arguments: LabeledExprListSyntax(itemsBuilder: {
                                                        LabeledExprSyntax(expression: ExprSyntax(stringLiteral: "\"Defer: \\(#function) exited\""))
                                                    }),
                                                    rightParen: .rightParenToken()
                                                )
                                            )
                                        )
                                    )
                            })
                        )
                    )
                )
            )
        )
    }
}
