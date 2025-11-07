#if os(macOS)
import AppKit

extension NSImage {
  /// Extracts the most prominent and unique colors from the image.
  ///
  /// Example usage:
  ///
  ///     do {
  ///       let colors = try image.extractColors(numberOfColors: 5)
  ///       for color in colors {
  ///         // Use the extracted colors for UI theming
  ///         view.layer?.backgroundColor = color.cgColor
  ///       }
  ///     } catch {
  ///       print("Failed to extract colors: \(error)")
  ///     }
  ///
  /// - Parameter numberOfColors: The number of prominent colors to extract (default is 4).
  /// - Returns: An array of NSColors representing the prominent colors.
  /// - Throws: `MusadoraKitError` if the image processing fails.
  func extractColors(numberOfColors: Int = 4) throws -> [NSColor] {
    guard self.cgImage(forProposedRect: nil, context: nil, hints: nil) != nil else {
      throw MusadoraKitError.invalidImage
    }

    let size = CGSize(width: 200, height: 200 * self.size.height / self.size.width)
    let resizedImage = NSImage(size: size)
    resizedImage.lockFocus()
    self.draw(in: NSRect(origin: .zero, size: size), from: .zero, operation: .copy, fraction: 1.0)
    resizedImage.unlockFocus()

    guard let resizedCGImage = resizedImage.cgImage(forProposedRect: nil, context: nil, hints: nil) else {
      throw MusadoraKitError.imageResizeFailed
    }

    let colors = try CommonImageProcessing.extractColors(from: resizedCGImage, numberOfColors: numberOfColors)
    return colors.compactMap { NSColor(cgColor: $0) }
  }
}
#endif
