//
//  Array.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 01/08/22.
//

import Foundation

extension Array where Element: Hashable {
  /// Returns a new array with the duplicate elements removed, preserving the order of first occurrence.
  ///
  /// - Returns: A new array with the duplicate elements removed.
  ///
  /// - Note: This method has O(n) time performance using a Set for efficient duplicate detection.
  func removeDuplicates() -> Self {
    var seen = Set<Element>()
    return filter { element in
      let inserted = seen.insert(element).inserted
      return inserted
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
