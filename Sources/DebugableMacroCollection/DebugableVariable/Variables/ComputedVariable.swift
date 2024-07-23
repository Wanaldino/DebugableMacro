//
//  ComputedVariable.swift
//  DebugableMacro
//
//  Created by Carlos Martinez on 14/12/24.
//

import SwiftSyntax
import SwiftSyntaxBuilder

struct ComputedVariable: Variable {
    let variable: VariableDeclSyntax
    let name: String
    let type: TypeSyntax
    let accessors: CodeBlockItemListSyntax

    init(variable: VariableDeclSyntax, accessors: CodeBlockItemListSyntax) throws(DebugableVariableMacroError) {
        self.variable = variable
        self.accessors = accessors

        guard let name = variable.bindings.first?.pattern.as(IdentifierPatternSyntax.self)?.identifier.text else {
            throw .nameNotFound
        }
        self.name = name

        guard let type = variable.bindings.first?.typeAnnotation?.type else {
            throw .typeNotFound
        }
        self.type = type
    }

    var body: [AccessorDeclSyntax] {
        // TODO: https://github.com/swiftlang/swift/issues/75715
//        [AccessorDeclSyntax(
//            accessorSpecifier: .keyword(.get),
//            bodyBuilder: {
//                WrappedFunction(variableName: name).body
//            }
//        )]
        return [AccessorDeclSyntax(
            stringLiteral: CodeBlockItemListSyntax(
                WrappedFunction(
                    variableName: name
                ).body
            ).description
        )]
    }
    var peer: [DeclSyntax] {
        [DeclSyntax(
            FunctionDeclSyntax(
                name: .identifier(
                    WrappedVariableName(
                        variableName: name
                    ).name
                ),
                signature: FunctionSignatureSyntax(
                    parameterClause: FunctionParameterClauseSyntax(
                        parameters: FunctionParameterListSyntax()
                    ),
                    returnClause: ReturnClauseSyntax(
                        type: type
                    )
                ),
                body: CodeBlockSyntax(
                    statements: accessors
                )
            )
        )]
    }
}

struct WrappedVariableName {
    let variableName: String
    var name: String {
        String(format: "__DebugableMacro_DebugableVariable_%@", variableName)
    }
}
