//
//  Capitalizable.swift
//  Capitalizable
//
//  Created by Rudrank Riyam on 26/07/22.
//

import Foundation

public protocol Capitalizable: RawRepresentable, CustomStringConvertible where RawValue == String {}

extension Capitalizable {
  public var description: String {
    rawValue.firstCharacterCapitalized
  }
}

extension String {
  var firstCharacterCapitalized: String {
    prefix(1).capitalized + dropFirst()
  }
}
