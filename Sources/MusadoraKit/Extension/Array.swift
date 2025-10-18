//
//  Array.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 01/08/22.
//

import Foundation

extension Array where Element: Equatable {
  /// Returns a new array with the duplicate elements removed.
  ///
  /// - Returns: A new array with the duplicate elements removed.
  ///
  /// - Note: This method has O(n²) time performance, but is optimized for arrays with no more than 10 elements.
  func removeDuplicates() -> Self {
    reduce(into: []) { result, element in
      if !result.contains(element) {
        result.append(element)
      }
    }
  }
}

extension Array where Element == String {
  /// Returns an array of arrays, each containing at most the specified number of elements.
  ///
  /// - Parameter size: The maximum number of elements in each chunk.
  ///
  /// - Returns: An array of arrays, each containing at most the specified number of elements.
  func chunked(into size: Int) -> [[Element]] {
    return stride(from: 0, to: count, by: size).map {
      Array(self[$0 ..< Swift.min($0 + size, count)])
    }
  }
}
