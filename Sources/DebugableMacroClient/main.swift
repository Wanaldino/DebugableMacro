import DebugableMacro

//@DebugableObject
struct Foo {
    var fooVar = 2

    func foo() -> Int {
        return 1
    }
}

//@DebugableFunction
//func foo() -> Int {
//    return 1
//}


@DebugableVariable
var foo: Int {
    1
}

print(foo)
