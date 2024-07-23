import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct DebugableMacroPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        DebugableFunctionMacro.self,
        DebugableVariableMacro.self,
        DebugableObjectMacro.self,
    ]
}
