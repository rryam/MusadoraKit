//
//  File.swift
//  
//
//  Created by Rudrank Riyam on 01/08/22.
//

import Foundation

// O(n²) time performance, but elements are not more than 10.
extension Array where Element: Equatable {
  func removeDuplicates() -> Self {
    reduce(into: []) { result, element in
      if !result.contains(element) {
        result.append(element)
      }
    }
  }
}
