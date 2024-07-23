import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(DebugableMacroCollection)
import DebugableMacroCollection

private let testMacros: [String: Macro.Type] = [
    "DebugableFunction": DebugableFunctionMacro.self,
]
#endif

final class DebugableFunctionMacroTests: XCTestCase {
    func test_noReturnImplicit() throws {
        #if canImport(DebugableMacroCollection)
        assertMacroExpansion("""
        @DebugableFunction
        func foo() -> Int {
            1
        }
        """,
        expandedSource: """
        func foo() -> Int {
            defer {
                print("Defer: Function \\(#function) exited")
            }
            let \(WrappedFunction.Constants.Result.function) = 1
            print("Return: Function \\(#function) returns \\(\(WrappedFunction.Constants.Result.function))")
            return \(WrappedFunction.Constants.Result.function)
        }
        """,
        macros: testMacros)
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }

    func test() throws {
        #if canImport(DebugableMacroCollection)
        assertMacroExpansion("""
        @DebugableFunction
        func foo() -> Int {
            let bool = true
        
            return if bool {
                1
            } else {
                2
            }
        }
        """,
        expandedSource: """
        func foo() -> Int {
            defer {
                print("Defer: Function \(#function) exited")
            }
            let bool = true
            let \(WrappedFunction.Constants.Result.function) = if bool {
                1
            } else {
                2
            }
            print("Return: Function \\(#function) returns \\(\(WrappedFunction.Constants.Result.function))")
            return \(WrappedFunction.Constants.Result.function)
        }
        """,
        macros: testMacros)
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
}
