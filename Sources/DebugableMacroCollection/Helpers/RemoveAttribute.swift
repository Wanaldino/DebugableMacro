//
//  RemoveAttribute.swift
//  DebugableMacro
//
//  Created by Carlos Martinez on 14/12/24.
//

import SwiftSyntax

struct RemoveAttribute {
    var attributeListSyntax: AttributeListSyntax

    init(name: String, from attributeListSyntax: AttributeListSyntax) {
        self.attributeListSyntax = attributeListSyntax.filter({ attribute in
            switch attribute {
            case .ifConfigDecl: true
            case .attribute(let syntax):
                syntax.attributeName.as(IdentifierTypeSyntax.self)?.name.text != name
            }
        })
    }
}
