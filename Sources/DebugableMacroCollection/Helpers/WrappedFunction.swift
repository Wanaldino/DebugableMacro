//
//  WrappedFunction.swift
//  DebugableMacro
//
//  Created by Carlos Martinez on 14/12/24.
//

import SwiftSyntax

public struct WrappedFunction {
    public enum Constants {
        public enum Result {
            public static let function = "__DebugableMacro_DebugableFunction__result"
            public static let variable = "__DebugableMacro_DebugableVariable__result"
        }
    }

    let functionName: String
    let functionArguments: LabeledExprListSyntax
    let result: String

    init(function: FunctionDeclSyntax) {
        self.functionName = WrappedFunctionName(function: function).name
        self.functionArguments = LabeledExprListSyntax {
            function.signature.parameterClause.parameters.map { param in
                let parameterToken = param.secondName ?? param.firstName
                let parameterName = parameterToken.text
                return LabeledExprSyntax(
                    label: parameterName,
                    expression: ExprSyntax(stringLiteral: parameterName)
                )
            }
        }
        self.result = Constants.Result.function
    }

    init(variableName: String) {
        self.functionName = WrappedVariableName(variableName: variableName).name
        self.functionArguments = LabeledExprListSyntax()
        self.result = Constants.Result.variable
    }

    var body: [CodeBlockItemSyntax] {
        let deferStatement = DeferStatement().statement

        let resultDefinition = VariableDeclSyntax(
            .let,
            name: PatternSyntax(stringLiteral: "\(result)"),
            initializer: InitializerClauseSyntax(
                equal: .equalToken(),
                value: ExprSyntax(
                    FunctionCallExprSyntax(
                        calledExpression: ExprSyntax(stringLiteral: functionName),
                        leftParen: .leftParenToken(),
                        arguments: functionArguments,
                        rightParen: .rightParenToken()
                    )
                )
            )
        )
        let resultStatement = CodeBlockItemSyntax(item: CodeBlockItemSyntax.Item(resultDefinition))

        let printDefinition = """
        print("Return: Function \\(#function) returns \\(\(result))")
        """
        let printStatement = CodeBlockItemSyntax(stringLiteral: printDefinition)

        let returnDefinition = """
        return \(result)
        """
        let returnStatement = CodeBlockItemSyntax(stringLiteral: returnDefinition)

        return [deferStatement, resultStatement, printStatement, returnStatement]
    }
}




protocol WrapedName {
    var name: String { get }
    var syntaxName: TokenSyntax { get }
}

public struct WrappedFunctionName: WrapedName {
    let function: FunctionDeclSyntax
    var name: String {
        let functionName = function.name.text
        return String(format: "__DebugableMacro_DebugableFunction_%@", functionName)
    }
    var syntaxName: TokenSyntax {
        .identifier(name)
    }
}
