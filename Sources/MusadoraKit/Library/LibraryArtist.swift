//
//  LibraryArtist.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 17/08/21.
//

import MediaPlayer

public extension MLibrary {

  /// Fetch an artist from the user's library by using its identifier.
  ///
  ///     do {
  ///       let artist = try await MLibrary.artist(id: "12345")
  ///       print("Artist name: \(artist.name)")
  ///     } catch {
  ///       print("Error fetching artist: \(error.localizedDescription)")
  ///     }
  ///
  /// - Parameters:
  ///   - id: The unique identifier for the artist.
  /// - Returns: `Artist` matching the given identifier.
  ///
  /// - Note: This method fetches the artist locally from the device when using iOS 16+
  ///  and is faster because it uses the latest `MusicLibraryRequest` structure.
  ///  For iOS 15 devices, it uses the custom structure `MusicLibraryResourceRequest`
  ///  that fetches the data from Apple Music API.
  static func artist(id: MusicItemID) async throws -> Artist {
    if #available(iOS 16.0, tvOS 16.0, watchOS 9.0, macOS 14, macCatalyst 17.0, visionOS 1.0, *) {
      var request = MusicLibraryRequest<Artist>()
      request.filter(matching: \.id, equalTo: id)
      let response = try await request.response()
      
      guard let artist = response.items.first else {
        throw MusadoraKitError.notFound(for: id.rawValue)
      }
      return artist
    } else {
      let request = MLibraryResourceRequest<Artist>(matching: \.id, equalTo: id)
      let response = try await request.response()
      
      guard let artist = response.items.first else {
        throw MusadoraKitError.notFound(for: id.rawValue)
      }
      return artist
    }
  }

  /// Fetch all artists from the user's library in alphabetical order.
  ///
  /// - Parameters:
  ///   - limit: The number of artists returned.
  /// - Returns: `Artists` for the given limit.
  ///
  /// - Note: This method fetches the artist locally from the device when using iOS 16+
  ///  and is much faster because it uses the latest `MusicLibraryRequest` structure.
  ///
  ///  For iOS 15, it uses the custom structure `MusicLibraryResourceRequest`
  ///  that fetches the data from Apple Music API that does not fetch all the artists in one request.
  static func artists(limit: Int = 50) async throws -> Artists {
    if #available(iOS 16.0, tvOS 16.0, watchOS 9.0, macOS 14.0, macCatalyst 17.0, visionOS 1.0, *) {
      var request = MusicLibraryRequest<Artist>()
      request.limit = limit
      let response = try await request.response()
      return response.items
    } else {
      var request = MLibraryResourceRequest<Artist>()
      request.limit = limit
      let response = try await request.response()
      return response.items
    }
  }

  /// Fetch multiple artists from the user's library by using their identifiers.
  ///
  ///     do {
  ///       let artistIDs = ["12345", "67890"]
  ///       let artists = try await MLibrary.artists(ids: artistIDs)
  ///
  ///       for artist in artists {
  ///         print("Artist name: \(artist.name)")
  ///         print("Artist genres: \(artist.genreNames)")
  ///       }
  ///     } catch {
  ///       print("Error fetching artists: \(error.localizedDescription)")
  ///     }
  ///
  /// - Parameters:
  ///   - ids: The unique identifiers for the artists.
  /// - Returns: `Artists` matching the given identifiers.
  ///
  /// - Note: This method fetches the artist locally from the device when using iOS 16+
  ///  and is faster because it uses the latest `MusicLibraryRequest` structure.
  ///  For iOS 15 devices, it uses the custom structure `MusicLibraryResourceRequest`
  ///  that fetches the data from Apple Music API.
  static func artists(ids: [MusicItemID]) async throws -> Artists {
    if #available(iOS 16.0, tvOS 16.0, watchOS 9.0, macOS 14, macCatalyst 17.0, visionOS 1.0, *) {
      var request = MusicLibraryRequest<Artist>()
      request.filter(matching: \.id, memberOf: ids)
      let response = try await request.response()
      return response.items
    } else {
      let request = MLibraryResourceRequest<Artist>(matching: \.id, memberOf: ids)
      let response = try await request.response()
      return response.items
    }
  }

  /// Accesses the total number of artists in the user's music library.
  ///
  /// Example usage:
  /// ```
  /// do {
  ///     let artistCount = try await MLibrary.artistsCount
  ///     print("The total number of artists in the user's library is \(artistCount).")
  /// } catch {
  ///     print("Error accessing the total number of artists: \(error.localizedDescription)")
  /// }
  /// ```
  @available(iOS 16.0, tvOS 16.0, watchOS 9.0, macOS 14.0, macCatalyst 17.0, visionOS 1.0, *)
  static var artistsCount: Int {
    get async throws {
      let request = MusicLibraryRequest<Artist>()
      let collection = try await request.response().items.collectingAll()
      return collection.count
    }
  }

  /// Access the total number of artists in the user's library.
  @available(macOS, unavailable)
  @available(macCatalyst, unavailable)
  @available(tvOS, unavailable)
  @available(watchOS, unavailable)
  static var artistsItemsCount: Int {
    get async throws {
      if let items = MPMediaQuery.artists().items {
        return items.count
      } else {
        throw MediaPlayError.notFound(for: "artists")
      }
    }
  }
}
