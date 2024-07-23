//
//  DebugableVariableMacroError.swift
//  DebugableMacro
//
//  Created by Carlos Martinez on 13/12/24.
//

public enum DebugableVariableMacroError {
    case variableOnly
    case variableNotIdentified
    case nameNotFound
    case typeNotFound
}

extension DebugableVariableMacroError: Error, CustomStringConvertible {
    public var description: String {
        switch self {
        case .variableOnly: "Only aplicable to variables"
        case .variableNotIdentified: "Cannot identify a var or let variable"
        case .nameNotFound: "Cannot find the name of the variable"
        case .typeNotFound: "Variable type not found"
        }
    }
}
