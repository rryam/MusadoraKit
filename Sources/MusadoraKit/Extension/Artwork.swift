//
//  Artwork.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 10/14/24.
//

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

import Foundation
import SwiftUI

extension Artwork {

  /// Fetches the artwork image and extracts prominent colors from it.
  ///
  /// This function downloads the artwork image from a specified URL, processes it to extract
  /// the most prominent colors, and returns them as an array of SwiftUI `Color` objects.
  ///
  /// - Parameters:
  ///   - width: The desired width of the artwork image.
  ///   - height: The desired height of the artwork image.
  ///   - numberOfColors: The number of prominent colors to extract. Default is 9.
  ///
  /// - Returns: An array of SwiftUI `Color` objects representing the prominent colors.
  ///
  /// - Throws: An error if the image cannot be fetched or processed.
  public func fetchColors(width: Int, height: Int, numberOfColors: Int = 9) async throws -> [Color] {
    guard let imageURL = self.url(width: width, height: height) else {
      throw NSError(domain: "Invalid artwork URL", code: 0, userInfo: nil)
    }

    let (data, _) = try await URLSession.shared.data(from: imageURL)

#if canImport(UIKit)
    guard let image = UIImage(data: data) else {
      throw NSError(domain: "Invalid image data", code: 0, userInfo: nil)
    }
#elseif canImport(AppKit)
    guard let image = NSImage(data: data) else {
      throw NSError(domain: "Invalid image data", code: 0, userInfo: nil)
    }
#endif

    let colors = try image.extractColors(numberOfColors: numberOfColors)
    return colors.map { Color($0) }
  }
}
