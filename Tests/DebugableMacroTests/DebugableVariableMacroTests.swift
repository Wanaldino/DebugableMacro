import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(DebugableMacroCollection)
import DebugableMacroCollection

private let testMacros: [String: Macro.Type] = [
    "DebugableVariable": DebugableVariableMacro.self,
]
#endif

final class DebugableVariableMacroTests: XCTestCase {
    func testSimpleVarVariable() {
#if canImport(DebugableMacroCollection)
        assertMacroExpansion(
            """
            @DebugableVariable
            var foo = 1
            """,
            expandedSource: """
            var foo = 1 {
                didSet {
                    print()
                }
            }
            """,
            macros: testMacros
        )
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }

    func testSimpleLetVariable() {
#if canImport(DebugableMacroCollection)
        assertMacroExpansion(
            """
            @DebugableVariable
            let foo = 1
            """,
            expandedSource: """
            let foo = 1
            """,
            macros: testMacros
        )
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }

    func testComputedVariable() {
#if canImport(DebugableMacroCollection)
assertMacroExpansion(
    """
    @DebugableVariable
    var foo: Int {
        1
    }
    """,
    expandedSource: """
    var foo: Int = 1 {
        didSet {
            print()
        }
    }
    """,
    macros: testMacros
)
#else
throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
}

    func testAccessorVariable() throws {
#if canImport(DebugableMacroCollection)
        assertMacroExpansion(
            """
            @DebugableVariable
            var foo: Int = 0 {
                didSet {
                    print()
                }
            }
            """,
            expandedSource: """
            var foo: Int {
                1
            }
            """,
            macros: testMacros)
#else
        throw XCTSkip("macros are only supported when running tests for the host platform")
#endif
    }
}
