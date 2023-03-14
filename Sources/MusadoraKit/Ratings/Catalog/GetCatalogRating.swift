//
//  GetCatalogRating.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 24/12/22.
//

import Foundation


public extension MCatalog {

  /// Get the rating for an album in the catalog.
  ///
  ///  Example:
  ///   ```swift
  ///  do  {
  ///    let rating = try await MCatalog.getRating(for: album)
  ///  } catch {
  ///    print("Error getting the rating for the album \(album) from catalog: \(error).")
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - album: The album to get the rating for.
  /// - Returns: The rating for the album as `Rating` object.
  ///
  /// - Throws: `MCatalogError.notFound`: If the album is not found in the catalog.
  static func getRating(for album: Album) async throws -> Rating {
    try await getRating(with: album.id, item: .album)
  }

  /// Get the ratings for albums in the catalog.
  ///
  ///  Example:
  ///   ```swift
  ///  do  {
  ///    let ratings = try await MCatalog.getRatings(for: albums)
  ///  } catch {
  ///    // Handle the error.
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - albums: The albums to get the rating for.
  /// - Returns: The ratings for the albums as an array of `Rating` object.
  static func getRatings(for albums: Albums) async throws -> Ratings {
    try await getRating(with: albums.map { $0.id }, item: .album)
  }

  /// Get the rating for a song in the catalog.
  ///
  ///  Example:
  ///   ```swift
  ///  do  {
  ///    let rating = try await MCatalog.getRating(for: song)
  ///  } catch {
  ///    print("Error getting the rating for the song \(song) from catalog: \(error).")
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - song: The song to get the rating for.
  /// - Returns: The rating for the song as `Rating` object.
  ///
  /// - Throws: `MCatalogError.notFound`: If the song is not found in the catalog.
  static func getRating(for song: Song) async throws -> Rating {
    try await getRating(with: song.id, item: .song)
  }

  /// Get the ratings for songs in the catalog.
  ///
  ///  Example:
  ///   ```swift
  ///  do  {
  ///    let ratings = try await MCatalog.getRatings(for: songs)
  ///  } catch {
  ///    // Handle the error.
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - songs: The songs to get the rating for.
  /// - Returns: The ratings for the songs as an array of `Rating` object.
  static func getRatings(for songs: Songs) async throws -> Ratings {
    try await getRating(with: songs.map { $0.id }, item: .song)
  }

  /// Get the rating for a music video in the catalog.
  ///
  ///  Example:
  ///   ```swift
  ///  do  {
  ///    let rating = try await MCatalog.getRating(for: musicVideo)
  ///  } catch {
  ///    print("Error getting the rating for the music video \(musicVideo) from catalog: \(error).")
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - musicVideo: The music video to get the rating for.
  /// - Returns: The rating for the music video as `Rating` object.
  ///
  /// - Throws: `MCatalogError.notFound`: If the music video is not found in the catalog.
  static func getRating(for musicVideo: MusicVideo) async throws -> Rating {
    try await getRating(with: musicVideo.id, item: .musicVideo)
  }

  /// Get the ratings for music videos in the catalog.
  ///
  ///  Example:
  ///   ```swift
  ///  do  {
  ///    let rating = try await MCatalog.getRatings(for: musicVideos)
  ///  } catch {
  ///    // Handle the error.
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - musicVideos: The music videos to get the rating for.
  /// - Returns: The ratings for the music videos as an array of `Rating` object.
  static func getRatings(for musicVideos: MusicVideos) async throws -> Ratings {
    try await getRating(with: musicVideos.map { $0.id }, item: .musicVideo)
  }

  /// Get the rating for a playlist in the catalog.
  ///
  ///  Example:
  ///   ```swift
  ///  do  {
  ///    let rating = try await MCatalog.getRating(for: playlist)
  ///  } catch {
  ///    print("Error getting the rating for the playlist \(playlist) from catalog: \(error).")
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - playlist: The playlist to get the rating for.
  /// - Returns: The rating for the playlist as `Rating` object.
  ///
  /// - Throws: `MCatalogError.notFound`: If the playlist is not found in the catalog.
  static func getRating(for playlist: Playlist) async throws -> Rating {
    try await getRating(with: playlist.id, item: .playlist)
  }

  /// Get the ratings for playlists in the catalog.
  ///
  ///  Example:
  ///   ```swift
  ///  do  {
  ///    let rating = try await MCatalog.getRatings(for: playlists)
  ///  } catch {
  ///    // Handle the error.
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - playlists: The playlists to get the rating for.
  /// - Returns: The ratings for the playlists as an array of `Rating` object.
  static func getRatings(for playlists: Playlists) async throws -> Ratings {
    try await getRating(with: playlists.map { $0.id }, item: .playlist)
  }

  /// Get the rating for a station in the catalog.
  ///
  ///  Example:
  ///   ```swift
  ///  do  {
  ///    let rating = try await MCatalog.getRating(for: station)
  ///  } catch {
  ///    print("Error getting the rating for the station \(station) from catalog: \(error).")
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - station: The station to get the rating for.
  /// - Returns: The rating for the station as `Rating` object.
  ///
  /// - Throws: `MCatalogError.notFound`: If the station is not found in the catalog.
  static func getRating(for station: Station) async throws -> Rating {
    try await getRating(with: station.id, item: .station)
  }

  /// Get the ratings for stations in the catalog.
  ///
  ///  Example:
  ///   ```swift
  ///  do  {
  ///    let rating = try await MCatalog.getRatings(for: stations)
  ///  } catch {
  ///    // Handle the error.
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - stations: The stations to get the rating for.
  /// - Returns: The ratings for the stations as an array of `Rating` object.
  static func getRatings(for stations: Stations) async throws -> Ratings {
    try await getRating(with: stations.map { $0.id }, item: .station)
  }

  /// Get the rating for a music item in the catalog.
  ///
  ///  Example:
  ///   ```swift
  ///  do  {
  ///    let id: MusicItemID = "12345678"
  ///    let rating = try await MCatalog.getRating(for: id)
  ///  } catch {
  ///    print("Error getting the rating for the music item with ID \(id) from catalog: \(error).")
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - id: The unique identifier of the music item to get the rating for.
  ///   - item: The type of the music item to get the rating for.
  /// - Returns: The rating for the music item as `Rating` object.
  ///
  /// - Throws: `MCatalogError.notFound`: If the music item with the specified ID is not found in the catalog.
  static func getRating(with id: MusicItemID, item: CatalogRatingMusicItemType) async throws -> Rating {
    let request = MCatalogRatingRequest(with: id, item: item)
    let response = try await request.response()

    guard let rating = response.data.first else {
      throw MRatingError.notFound(for: id.rawValue)
    }
    return rating
  }

  /// Get the ratings for music items in the catalog.
  ///
  ///  Example:
  ///   ```swift
  ///  do  {
  ///    let ids: [MusicItemID] = ["12345678", "87653214"]
  ///    let rating = try await MCatalog.getRating(for: ids)
  ///  } catch {
  ///    print("Error getting the rating for the music items with IDs \(ids) from catalog: \(error).")
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - ids: The unique identifiers of the music items to get the rating for.
  ///   - item: The type of the music items to get the rating for.
  /// - Returns: The ratings for the music items as an array of `Rating` object.
  ///
  /// - Throws: `MCatalogError.notFound`: If the music items with the IDs is not found in the catalog.
  static func getRating(with ids: [MusicItemID], item: CatalogRatingMusicItemType) async throws -> Ratings {
    let request = MCatalogRatingRequest(with: ids, item: item)
    let response = try await request.response()
    return response.data
  }
}
