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
  /// - Parameter numberOfColors: The number of prominent colors to extract (default is 4).
  /// - Returns: An array of UIColors representing the prominent colors.
  func extractColors(numberOfColors: Int = 4) throws -> [UIColor] {
    let size = CGSize(width: 200, height: 200 * self.size.height / self.size.width)
    UIGraphicsBeginImageContext(size)
    self.draw(in: CGRect(origin: .zero, size: size))
    guard let resizedImage = UIGraphicsGetImageFromCurrentImageContext() else {
      UIGraphicsEndImageContext()
      throw ImageProcessingError.resizeFailed
    }
    UIGraphicsEndImageContext()

    let colors = try CommonImageProcessing.extractColors(from: resizedImage.cgImage!, numberOfColors: numberOfColors)
    return colors.map { UIColor(cgColor: $0) }
  }
}
#endif
