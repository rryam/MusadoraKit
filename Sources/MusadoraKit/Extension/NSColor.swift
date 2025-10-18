//
//  NSColor.swift
//  MusadoraKit
//
//  Created by AI Assistant on 09/02/25.
//

#if os(macOS)
import AppKit

extension NSColor {
  /// Converts the NSColor to its hexadecimal string representation.
  ///
  /// This property provides a convenient way to obtain the hexadecimal string
  /// representation of an NSColor. It attempts to convert the color to the sRGB
  /// color space before calculating the hex value. If the conversion fails,
  /// it returns a default black color hex string.
  ///
  /// - Returns: A string representing the color in hexadecimal format (#RRGGBB).
  ///            Returns "#000000" (black) if the color cannot be converted to sRGB.
  ///
  /// - Note: The returned string is always uppercase and includes the "#" prefix.
  var hexString: String {
    guard let rgbColor = usingColorSpace(.sRGB) else {
      return "#000000"
    }

    let r = Int(round(rgbColor.redComponent * 255))
    let g = Int(round(rgbColor.greenComponent * 255))
    let b = Int(round(rgbColor.blueComponent * 255))

    return String(format: "#%02X%02X%02X", r, g, b)
  }
}
#endif
