//
//  Plugin.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 21/06/25.
//

import SwiftCompilerPlugin
import SwiftSyntaxMacros

@main
struct MusadoraKitMacrosPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        CatalogEndpointMacro.self
    ]
}