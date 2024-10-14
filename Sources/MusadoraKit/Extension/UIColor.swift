//
//  UIColor.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 10/14/24.
//

#if os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
import UIKit

extension UIColor {
  /// Converts the UIColor to its hexadecimal string representation.
  ///
  /// This property provides a convenient way to obtain the hexadecimal string
  /// representation of a UIColor. It uses the color's RGB components to calculate
  /// the hex value.
  ///
  /// - Returns: A string representing the color in hexadecimal format (#RRGGBB).
  ///            Returns "#000000" (black) if the color components cannot be retrieved.
  ///
  /// - Note: The returned string is always uppercase and includes the "#" prefix.
  var hexString: String {
    guard let components = self.cgColor.components, components.count >= 3 else {
      return "#000000"
    }
    
    let r = Int(components[0] * 255.0)
    let g = Int(components[1] * 255.0)
    let b = Int(components[2] * 255.0)
    
    return String(format: "#%02X%02X%02X", r, g, b)
  }
}
#endif
