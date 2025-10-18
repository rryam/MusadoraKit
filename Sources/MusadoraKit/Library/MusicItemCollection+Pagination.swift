//
//  MusicItemCollection+Pagination.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 11/10/25.
//

import Foundation

extension MusicItemCollection {
  /// Loads subsequent batches for the current collection until either the next batch is
  /// unavailable or the desired number of items has been gathered.
  ///
  /// - Parameter desiredCount: An optional cap for the total number of items to keep.
  /// - Returns: A collection containing the aggregated items.
  /// - Throws: Errors propagated from the underlying MusicKit request.
  func collectingAll(upTo desiredCount: Int? = nil) async throws -> Self {
    var collection = self

    func shouldContinue() -> Bool {
      if let desiredCount {
        return collection.count < desiredCount && collection.hasNextBatch
      }
      return collection.hasNextBatch
    }

    while shouldContinue(), let nextBatch = try await collection.nextBatch() {
      collection += nextBatch
    }

    if let desiredCount, collection.count > desiredCount {
      collection = Self(Array(collection.prefix(desiredCount)))
    }

    return collection
  }
}
