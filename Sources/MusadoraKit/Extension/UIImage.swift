//
//  UIImage.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 10/14/24.
//

#if os(iOS) || os(tvOS) || os(visionOS) || os(watchOS)
import UIKit

extension UIImage {
  /// Extracts the most prominent and unique colors from the image.
  ///
  /// Example usage:
  ///
  ///     do {
  ///       let colors = try image.extractColors(numberOfColors: 5)
  ///       for color in colors {
  ///         // Use the extracted colors for UI theming
  ///         view.backgroundColor = color
  ///       }
  ///     } catch {
  ///       print("Failed to extract colors: \(error)")
  ///     }
  ///
  /// - Parameter numberOfColors: The number of prominent colors to extract (default is 4).
  /// - Returns: An array of UIColors representing the prominent colors.
  /// - Throws: `MusadoraKitError` if the image processing fails.
  func extractColors(numberOfColors: Int = 4) throws -> [UIColor] {
    let size = CGSize(width: 200, height: 200 * self.size.height / self.size.width)
    UIGraphicsBeginImageContext(size)
    self.draw(in: CGRect(origin: .zero, size: size))
    guard let resizedImage = UIGraphicsGetImageFromCurrentImageContext() else {
      UIGraphicsEndImageContext()
      throw MusadoraKitError.imageResizeFailed
    }
    UIGraphicsEndImageContext()

    guard let cgImage = resizedImage.cgImage else {
      throw MusadoraKitError.invalidImage
    }
    let colors = try CommonImageProcessing.extractColors(from: cgImage, numberOfColors: numberOfColors)
    return colors.map { UIColor(cgColor: $0) }
  }
}
#endif
