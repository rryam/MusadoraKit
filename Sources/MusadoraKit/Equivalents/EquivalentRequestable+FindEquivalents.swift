//
//  EquivalentRequestable+FindEquivalents.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 17/02/26.
//

import Foundation

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
    #if compiler(>=6.3)
    if #available(iOS 26.4, macOS 26.4, tvOS 26.4, watchOS 26.4, visionOS 26.4, *) {
      return try await equivalentInCurrentStorefrontUsingMusicKit()
    }
    #endif

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
    #if compiler(>=6.3)
    if #available(iOS 26.4, macOS 26.4, tvOS 26.4, watchOS 26.4, visionOS 26.4, *) {
      let ids = map(\.id)
      var request = MusicCatalogResourceRequest<MusicItemType>(matching: \.id, memberOf: ids)
      request.options = [.findEquivalents]
      let response = try await request.response()
      return try await response.items.collectingAll(upTo: ids.count)
    }
    #endif

    let storefront = try await MusicDataRequest.currentCountryCode
    return try await equivalents(for: storefront)
  }
}

#if compiler(>=6.3)
@available(iOS 26.4, macOS 26.4, tvOS 26.4, watchOS 26.4, visionOS 26.4, *)
private extension EquivalentRequestable where Self: FilterableMusicItem {
  func equivalentInCurrentStorefrontUsingMusicKit() async throws -> Self {
    var request = MusicCatalogResourceRequest<Self>(matching: \.id, equalTo: id)
    request.options = [.findEquivalents]
    let response = try await request.response()

    guard let item = response.items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }

    return item
  }
}
#endif
