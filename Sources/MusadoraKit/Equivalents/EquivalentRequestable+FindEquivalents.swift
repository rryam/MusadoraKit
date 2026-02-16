//
//  EquivalentRequestable+FindEquivalents.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 17/02/26.
//

public extension EquivalentRequestable where Self == Song {
  /// Fetches the equivalent song in the user's current storefront.
  ///
  /// On MusicKit 26.4+ this uses `MusicCatalogResourceRequestOption.findEquivalents`.
  /// On earlier OS versions it falls back to the Apple Music API `filter[equivalents]` endpoint.
  ///
  /// - Returns: The equivalent song that exists in the user's current storefront.
  func equivalentInCurrentStorefront() async throws -> Song {
    #if compiler(>=6.3)
    if #available(iOS 26.4, macOS 26.4, tvOS 26.4, watchOS 26.4, visionOS 26.4, *) {
      return try await equivalentInCurrentStorefrontUsingMusicKit()
    }
    #endif

    let storefront = try await MusicDataRequest.currentCountryCode
    return try await equivalent(for: storefront)
  }
}

public extension EquivalentRequestable where Self == Album {
  /// Fetches the equivalent album in the user's current storefront.
  ///
  /// On MusicKit 26.4+ this uses `MusicCatalogResourceRequestOption.findEquivalents`.
  /// On earlier OS versions it falls back to the Apple Music API `filter[equivalents]` endpoint.
  ///
  /// - Returns: The equivalent album that exists in the user's current storefront.
  func equivalentInCurrentStorefront() async throws -> Album {
    #if compiler(>=6.3)
    if #available(iOS 26.4, macOS 26.4, tvOS 26.4, watchOS 26.4, visionOS 26.4, *) {
      return try await equivalentInCurrentStorefrontUsingMusicKit()
    }
    #endif

    let storefront = try await MusicDataRequest.currentCountryCode
    return try await equivalent(for: storefront)
  }
}

public extension EquivalentRequestable where Self == MusicVideo {
  /// Fetches the equivalent music video in the user's current storefront.
  ///
  /// On MusicKit 26.4+ this uses `MusicCatalogResourceRequestOption.findEquivalents`.
  /// On earlier OS versions it falls back to the Apple Music API `filter[equivalents]` endpoint.
  ///
  /// - Returns: The equivalent music video that exists in the user's current storefront.
  func equivalentInCurrentStorefront() async throws -> MusicVideo {
    #if compiler(>=6.3)
    if #available(iOS 26.4, macOS 26.4, tvOS 26.4, watchOS 26.4, visionOS 26.4, *) {
      return try await equivalentInCurrentStorefrontUsingMusicKit()
    }
    #endif

    let storefront = try await MusicDataRequest.currentCountryCode
    return try await equivalent(for: storefront)
  }
}

public extension MusicItemCollection where MusicItemType == Song {
  /// Fetches equivalent songs for the user's current storefront.
  ///
  /// On MusicKit 26.4+ this uses `MusicCatalogResourceRequestOption.findEquivalents`.
  /// On earlier OS versions it falls back to the Apple Music API `filter[equivalents]` endpoint.
  ///
  /// - Returns: A collection of equivalent songs for the user's current storefront.
  func equivalentsInCurrentStorefront() async throws -> Songs {
    #if compiler(>=6.3)
    if #available(iOS 26.4, macOS 26.4, tvOS 26.4, watchOS 26.4, visionOS 26.4, *) {
      let ids = map(\.id)
      var request = MusicCatalogResourceRequest<Song>(matching: \.id, memberOf: ids)
      request.options = [MusicCatalogResourceRequestOption.findEquivalents]
      let response = try await request.response()
      return try await response.items.collectingAll(upTo: ids.count)
    }
    #endif

    let storefront = try await MusicDataRequest.currentCountryCode
    return try await equivalents(for: storefront)
  }
}

public extension MusicItemCollection where MusicItemType == Album {
  /// Fetches equivalent albums for the user's current storefront.
  ///
  /// On MusicKit 26.4+ this uses `MusicCatalogResourceRequestOption.findEquivalents`.
  /// On earlier OS versions it falls back to the Apple Music API `filter[equivalents]` endpoint.
  ///
  /// - Returns: A collection of equivalent albums for the user's current storefront.
  func equivalentsInCurrentStorefront() async throws -> Albums {
    #if compiler(>=6.3)
    if #available(iOS 26.4, macOS 26.4, tvOS 26.4, watchOS 26.4, visionOS 26.4, *) {
      let ids = map(\.id)
      var request = MusicCatalogResourceRequest<Album>(matching: \.id, memberOf: ids)
      request.options = [MusicCatalogResourceRequestOption.findEquivalents]
      let response = try await request.response()
      return try await response.items.collectingAll(upTo: ids.count)
    }
    #endif

    let storefront = try await MusicDataRequest.currentCountryCode
    return try await equivalents(for: storefront)
  }
}

public extension MusicItemCollection where MusicItemType == MusicVideo {
  /// Fetches equivalent music videos for the user's current storefront.
  ///
  /// On MusicKit 26.4+ this uses `MusicCatalogResourceRequestOption.findEquivalents`.
  /// On earlier OS versions it falls back to the Apple Music API `filter[equivalents]` endpoint.
  ///
  /// - Returns: A collection of equivalent music videos for the user's current storefront.
  func equivalentsInCurrentStorefront() async throws -> MusicVideos {
    #if compiler(>=6.3)
    if #available(iOS 26.4, macOS 26.4, tvOS 26.4, watchOS 26.4, visionOS 26.4, *) {
      let ids = map(\.id)
      var request = MusicCatalogResourceRequest<MusicVideo>(matching: \.id, memberOf: ids)
      request.options = [MusicCatalogResourceRequestOption.findEquivalents]
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
