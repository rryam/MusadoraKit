//
//  EquivalentRequestable+FindEquivalents.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 17/02/26.
//

public extension EquivalentRequestable where Self == Song {
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
  func equivalentInCurrentStorefront() async throws -> Song {
    let storefront = try await MusicDataRequest.currentCountryCode

    #if compiler(>=6.3)
    if #available(iOS 26.4, macOS 26.4, tvOS 26.4, watchOS 26.4, visionOS 26.4, *) {
      return try await equivalentInCurrentStorefrontUsingMusicKit()
    }
    #endif

    return try await equivalent(for: storefront)
  }
}

public extension EquivalentRequestable where Self == Album {
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
  func equivalentInCurrentStorefront() async throws -> Album {
    let storefront = try await MusicDataRequest.currentCountryCode

    #if compiler(>=6.3)
    if #available(iOS 26.4, macOS 26.4, tvOS 26.4, watchOS 26.4, visionOS 26.4, *) {
      return try await equivalentInCurrentStorefrontUsingMusicKit()
    }
    #endif

    return try await equivalent(for: storefront)
  }
}

public extension EquivalentRequestable where Self == MusicVideo {
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
  func equivalentInCurrentStorefront() async throws -> MusicVideo {
    let storefront = try await MusicDataRequest.currentCountryCode

    #if compiler(>=6.3)
    if #available(iOS 26.4, macOS 26.4, tvOS 26.4, watchOS 26.4, visionOS 26.4, *) {
      return try await equivalentInCurrentStorefrontUsingMusicKit()
    }
    #endif

    return try await equivalent(for: storefront)
  }
}

public extension MusicItemCollection where MusicItemType == Song {
  /// Fetches equivalent music items for the user's current storefront.
  ///
  /// On MusicKit 26.4+ (when built with a toolchain/SDK that includes it), this uses
  /// `MusicCatalogResourceRequestOption.findEquivalents` to resolve cross-storefront identifiers.
  ///
  /// On earlier OS versions (or when built with older SDKs), it falls back to the Apple Music API
  /// `filter[equivalents]` endpoint using `MusicDataRequest`.
  ///
  /// - Returns: A collection of equivalent music items for the user's current storefront.
  func equivalentsInCurrentStorefront() async throws -> Songs {
    let storefront = try await MusicDataRequest.currentCountryCode

    #if compiler(>=6.3)
    if #available(iOS 26.4, macOS 26.4, tvOS 26.4, watchOS 26.4, visionOS 26.4, *) {
      let ids = map(\.id)
      var request = MusicCatalogResourceRequest<Song>(matching: \.id, memberOf: ids)
      request.options = [MusicCatalogResourceRequestOption.findEquivalents]
      let response = try await request.response()
      return try await response.items.collectingAll(upTo: ids.count)
    }
    #endif

    return try await equivalents(for: storefront)
  }
}

public extension MusicItemCollection where MusicItemType == Album {
  /// Fetches equivalent music items for the user's current storefront.
  ///
  /// On MusicKit 26.4+ (when built with a toolchain/SDK that includes it), this uses
  /// `MusicCatalogResourceRequestOption.findEquivalents` to resolve cross-storefront identifiers.
  ///
  /// On earlier OS versions (or when built with older SDKs), it falls back to the Apple Music API
  /// `filter[equivalents]` endpoint using `MusicDataRequest`.
  ///
  /// - Returns: A collection of equivalent music items for the user's current storefront.
  func equivalentsInCurrentStorefront() async throws -> Albums {
    let storefront = try await MusicDataRequest.currentCountryCode

    #if compiler(>=6.3)
    if #available(iOS 26.4, macOS 26.4, tvOS 26.4, watchOS 26.4, visionOS 26.4, *) {
      let ids = map(\.id)
      var request = MusicCatalogResourceRequest<Album>(matching: \.id, memberOf: ids)
      request.options = [MusicCatalogResourceRequestOption.findEquivalents]
      let response = try await request.response()
      return try await response.items.collectingAll(upTo: ids.count)
    }
    #endif

    return try await equivalents(for: storefront)
  }
}

public extension MusicItemCollection where MusicItemType == MusicVideo {
  /// Fetches equivalent music items for the user's current storefront.
  ///
  /// On MusicKit 26.4+ (when built with a toolchain/SDK that includes it), this uses
  /// `MusicCatalogResourceRequestOption.findEquivalents` to resolve cross-storefront identifiers.
  ///
  /// On earlier OS versions (or when built with older SDKs), it falls back to the Apple Music API
  /// `filter[equivalents]` endpoint using `MusicDataRequest`.
  ///
  /// - Returns: A collection of equivalent music items for the user's current storefront.
  func equivalentsInCurrentStorefront() async throws -> MusicVideos {
    let storefront = try await MusicDataRequest.currentCountryCode

    #if compiler(>=6.3)
    if #available(iOS 26.4, macOS 26.4, tvOS 26.4, watchOS 26.4, visionOS 26.4, *) {
      let ids = map(\.id)
      var request = MusicCatalogResourceRequest<MusicVideo>(matching: \.id, memberOf: ids)
      request.options = [MusicCatalogResourceRequestOption.findEquivalents]
      let response = try await request.response()
      return try await response.items.collectingAll(upTo: ids.count)
    }
    #endif

    return try await equivalents(for: storefront)
  }
}

#if compiler(>=6.3)
@available(iOS 26.4, macOS 26.4, tvOS 26.4, watchOS 26.4, visionOS 26.4, *)
private extension EquivalentRequestable where Self == Song {
  func equivalentInCurrentStorefrontUsingMusicKit() async throws -> Song {
    var request = MusicCatalogResourceRequest<Song>(matching: \.id, equalTo: id)
    request.options = [MusicCatalogResourceRequestOption.findEquivalents]
    let response = try await request.response()

    guard let item = response.items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }

    return item
  }
}

@available(iOS 26.4, macOS 26.4, tvOS 26.4, watchOS 26.4, visionOS 26.4, *)
private extension EquivalentRequestable where Self == Album {
  func equivalentInCurrentStorefrontUsingMusicKit() async throws -> Album {
    var request = MusicCatalogResourceRequest<Album>(matching: \.id, equalTo: id)
    request.options = [MusicCatalogResourceRequestOption.findEquivalents]
    let response = try await request.response()

    guard let item = response.items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }

    return item
  }
}

@available(iOS 26.4, macOS 26.4, tvOS 26.4, watchOS 26.4, visionOS 26.4, *)
private extension EquivalentRequestable where Self == MusicVideo {
  func equivalentInCurrentStorefrontUsingMusicKit() async throws -> MusicVideo {
    var request = MusicCatalogResourceRequest<MusicVideo>(matching: \.id, equalTo: id)
    request.options = [MusicCatalogResourceRequestOption.findEquivalents]
    let response = try await request.response()

    guard let item = response.items.first else {
      throw MusadoraKitError.notFound(for: id.rawValue)
    }

    return item
  }
}
#endif
