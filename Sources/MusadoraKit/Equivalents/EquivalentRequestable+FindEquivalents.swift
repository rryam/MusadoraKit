//
//  EquivalentRequestable+FindEquivalents.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 17/02/26.
//

public extension EquivalentRequestable where Self: FilterableMusicItem {
  /// Fetches the equivalent music item in the user's current storefront.
  ///
  /// This is helpful when you have an identifier from a different storefront and you want to resolve it into the
  /// current storefront.
  ///
  /// On MusicKit 26.4+ (when built with a toolchain/SDK that includes it), this uses
  /// `MusicCatalogResourceRequestOption.findEquivalents`.
  ///
  /// On earlier OS versions (or when built with older SDKs), it falls back to the Apple Music API
  /// `filter[equivalents]` endpoint using `MusicDataRequest`.
  ///
  /// - Returns: The equivalent item that exists in the user's current storefront.
  func equivalentInCurrentStorefront() async throws -> Self {
    let storefront = try await MusicDataRequest.currentCountryCode
    return try await equivalent(for: storefront)
  }
}

public extension MusicItemCollection where MusicItemType: EquivalentRequestable & FilterableMusicItem {
  /// Fetches equivalent music items for the user's current storefront.
  ///
  /// On MusicKit 26.4+ (when built with a toolchain/SDK that includes it), this uses
  /// `MusicCatalogResourceRequestOption.findEquivalents` to resolve cross-storefront identifiers.
  ///
  /// On earlier OS versions (or when built with older SDKs), it falls back to the Apple Music API
  /// `filter[equivalents]` endpoint using `MusicDataRequest`.
  ///
  /// - Returns: A collection of equivalent music items for the user's current storefront.
  func equivalentsInCurrentStorefront() async throws -> MusicItemCollection<MusicItemType> {
    let storefront = try await MusicDataRequest.currentCountryCode
    return try await equivalents(for: storefront)
  }
}

// MARK: - MusicKit 26.4 Overloads

#if compiler(>=6.3)

/// Generic helper that issues a `findEquivalents` catalog request for a single item.
@available(iOS 26.4, macOS 26.4, tvOS 26.4, watchOS 26.4, visionOS 26.4, *)
private func findEquivalent<T: EquivalentRequestable & FilterableMusicItem>(
  for item: T,
  filterKeyPath: KeyPath<T.FilterType, MusicItemID>
) async throws -> T {
  var request = MusicCatalogResourceRequest<T>(matching: filterKeyPath, equalTo: item.id)
  request.options = [MusicCatalogResourceRequestOption.findEquivalents]
  let response = try await request.response()

  guard let result = response.items.first else {
    throw MusadoraKitError.notFound(for: item.id.rawValue)
  }

  return result
}

/// Generic helper that issues a `findEquivalents` catalog request for a collection.
@available(iOS 26.4, macOS 26.4, tvOS 26.4, watchOS 26.4, visionOS 26.4, *)
private func findEquivalents<T: EquivalentRequestable & FilterableMusicItem>(
  for items: MusicItemCollection<T>,
  filterKeyPath: KeyPath<T.FilterType, MusicItemID>
) async throws -> MusicItemCollection<T> {
  let ids = items.map(\.id)
  var request = MusicCatalogResourceRequest<T>(matching: filterKeyPath, memberOf: ids)
  request.options = [MusicCatalogResourceRequestOption.findEquivalents]
  let response = try await request.response()
  return try await response.items.collectingAll(upTo: ids.count)
}

// Concrete overloads that shadow the generic fallback when compiled with Swift 6.3+.
// Swift dispatches to these more-specific signatures over the `FilterableMusicItem` extension.

public extension EquivalentRequestable where Self == Song {
  func equivalentInCurrentStorefront() async throws -> Song {
    if #available(iOS 26.4, macOS 26.4, tvOS 26.4, watchOS 26.4, visionOS 26.4, *) {
      return try await findEquivalent(for: self, filterKeyPath: \.id)
    }
    let storefront = try await MusicDataRequest.currentCountryCode
    return try await equivalent(for: storefront)
  }
}

public extension EquivalentRequestable where Self == Album {
  func equivalentInCurrentStorefront() async throws -> Album {
    if #available(iOS 26.4, macOS 26.4, tvOS 26.4, watchOS 26.4, visionOS 26.4, *) {
      return try await findEquivalent(for: self, filterKeyPath: \.id)
    }
    let storefront = try await MusicDataRequest.currentCountryCode
    return try await equivalent(for: storefront)
  }
}

public extension EquivalentRequestable where Self == MusicVideo {
  func equivalentInCurrentStorefront() async throws -> MusicVideo {
    if #available(iOS 26.4, macOS 26.4, tvOS 26.4, watchOS 26.4, visionOS 26.4, *) {
      return try await findEquivalent(for: self, filterKeyPath: \.id)
    }
    let storefront = try await MusicDataRequest.currentCountryCode
    return try await equivalent(for: storefront)
  }
}

public extension MusicItemCollection where MusicItemType == Song {
  func equivalentsInCurrentStorefront() async throws -> MusicItemCollection<Song> {
    if #available(iOS 26.4, macOS 26.4, tvOS 26.4, watchOS 26.4, visionOS 26.4, *) {
      return try await findEquivalents(for: self, filterKeyPath: \.id)
    }
    let storefront = try await MusicDataRequest.currentCountryCode
    return try await equivalents(for: storefront)
  }
}

public extension MusicItemCollection where MusicItemType == Album {
  func equivalentsInCurrentStorefront() async throws -> MusicItemCollection<Album> {
    if #available(iOS 26.4, macOS 26.4, tvOS 26.4, watchOS 26.4, visionOS 26.4, *) {
      return try await findEquivalents(for: self, filterKeyPath: \.id)
    }
    let storefront = try await MusicDataRequest.currentCountryCode
    return try await equivalents(for: storefront)
  }
}

public extension MusicItemCollection where MusicItemType == MusicVideo {
  func equivalentsInCurrentStorefront() async throws -> MusicItemCollection<MusicVideo> {
    if #available(iOS 26.4, macOS 26.4, tvOS 26.4, watchOS 26.4, visionOS 26.4, *) {
      return try await findEquivalents(for: self, filterKeyPath: \.id)
    }
    let storefront = try await MusicDataRequest.currentCountryCode
    return try await equivalents(for: storefront)
  }
}

#endif
