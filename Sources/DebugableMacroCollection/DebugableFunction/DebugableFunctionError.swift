//
//  DebugableFunctionError.swift
//  DebugableMacro
//
//  Created by Carlos Martinez on 13/12/24.
//


public enum DebugableFunctionError {
    case functionOnly
}
extension DebugableFunctionError: Error, CustomStringConvertible {
    public var description: String {
        switch self {
        case .functionOnly: "Only aplicable to functions"
        }
    }
}
