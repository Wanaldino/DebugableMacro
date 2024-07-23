@attached(memberAttribute)
public macro DebugableObject() = #externalMacro(module: "DebugableMacroCollection", type: "DebugableObjectMacro")

@attached(body)
@attached(peer, names: prefixed(__DebugableMacro_DebugableFunction_))
public macro DebugableFunction() = #externalMacro(module: "DebugableMacroCollection", type: "DebugableFunctionMacro")

@attached(accessor, names: overloaded)
@attached(peer, names: prefixed(__DebugableMacro_DebugableVariable_))
public macro DebugableVariable() = #externalMacro(module: "DebugableMacroCollection", type: "DebugableVariableMacro")
