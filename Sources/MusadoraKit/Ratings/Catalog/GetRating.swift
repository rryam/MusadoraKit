//
//  GetRating.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 24/12/22.
//

import Foundation
import MusicKit

public extension MCatalog {

  /// Get the rating for an album in the catalog.
  ///
  ///  Example:
  ///   ```
  ///  do  {
  ///    let rating = try await MCatalog.getRating(for: album)
  ///  } catch {
  ///    // Handle the error.
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - album: The album to get the rating for.
  /// - Returns: The rating for the album as `Rating` object.
  ///
  /// - Throws: `MCatalogError.notFound`: If the album is not found in the catalog.
  static func getRating(for album: Album) async throws -> Rating {
    let id = album.id
    let request = MCatalogRatingRequest(for: id, item: .album)
    let response = try await request.response()

    guard let rating = response.data.first else {
      throw MRatingError.notFound(for: id.rawValue)
    }
    return rating
  }

  /// Get the ratings for albums in the catalog.
  ///
  ///  Example:
  ///   ```
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
  static func getRatings(for albums: Albums) async throws -> [Rating] {
    let ids = albums.map { $0.id }
    let request = MCatalogRatingRequest(for: ids, item: .album)
    let response = try await request.response()
    return response.data
  }

  /// Get the rating for a song in the catalog.
  ///
  ///  Example:
  ///   ```
  ///  do  {
  ///    let rating = try await MCatalog.getRating(for: song)
  ///  } catch {
  ///    // Handle the error.
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - song: The song to get the rating for.
  /// - Returns: The rating for the song as `Rating` object.
  ///
  /// - Throws: `MCatalogError.notFound`: If the song with the specified ID is not found in the catalog.
  static func getRating(for song: Song) async throws -> Rating {
    let id = song.id
    let request = MCatalogRatingRequest(for: id, item: .song)
    let response = try await request.response()

    guard let rating = response.data.first else {
      throw MRatingError.notFound(for: id.rawValue)
    }
    return rating
  }

  /// Get the ratings for songs in the catalog.
  ///
  ///  Example:
  ///   ```
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
  static func getRatings(for songs: Songs) async throws -> [Rating] {
    let ids = songs.map { $0.id }
    let request = MCatalogRatingRequest(for: ids, item: .song)
    let response = try await request.response()
    return response.data
  }

  /// Get the rating for a music video in the catalog.
  ///
  ///  Example:
  ///   ```
  ///  do  {
  ///    let rating = try await MCatalog.getRating(for: musicVideo)
  ///  } catch {
  ///    // Handle the error.
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - musicVideo: The music video to get the rating for.
  /// - Returns: The rating for the music video as `Rating` object.
  ///
  /// - Throws: `MCatalogError.notFound`: If the music video with the specified ID is not found in the catalog.
  static func getRating(for musicVideo: MusicVideo) async throws -> Rating {
    let id = musicVideo.id
    let request = MCatalogRatingRequest(for: id, item: .musicVideo)
    let response = try await request.response()

    guard let rating = response.data.first else {
      throw MRatingError.notFound(for: id.rawValue)
    }
    return rating
  }

  /// Get the ratings for music videos in the catalog.
  ///
  ///  Example:
  ///   ```
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
  static func getRatings(for musicVideos: MusicVideos) async throws -> [Rating] {
    let ids = musicVideos.map { $0.id }
    let request = MCatalogRatingRequest(for: ids, item: .musicVideo)
    let response = try await request.response()
    return response.data
  }

  /// Get the rating for a playlist in the catalog.
  ///
  ///  Example:
  ///   ```
  ///  do  {
  ///    let rating = try await MCatalog.getRating(for: playlist)
  ///  } catch {
  ///    // Handle the error.
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - playlist: The playlist to get the rating for.
  /// - Returns: The rating for the playlist as `Rating` object.
  ///
  /// - Throws: `MCatalogError.notFound`: If the playlist with the specified ID is not found in the catalog.
  static func getRating(for playlist: Playlist) async throws -> Rating {
    let id = playlist.id
    let request = MCatalogRatingRequest(for: id, item: .playlist)
    let response = try await request.response()

    guard let rating = response.data.first else {
      throw MRatingError.notFound(for: id.rawValue)
    }
    return rating
  }

  /// Get the ratings for playlists in the catalog.
  ///
  ///  Example:
  ///   ```
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
  static func getRatings(for playlists: Playlists) async throws -> [Rating] {
    let ids = playlists.map { $0.id }
    let request = MCatalogRatingRequest(for: ids, item: .playlist)
    let response = try await request.response()
    return response.data
  }

  /// Get the rating for a station in the catalog.
  ///
  ///  Example:
  ///   ```
  ///  do  {
  ///    let rating = try await MCatalog.getRating(for: station)
  ///  } catch {
  ///    // Handle the error.
  ///  }
  ///  ```
  ///
  /// - Parameters:
  ///   - station: The station to get the rating for.
  /// - Returns: The rating for the station as `Rating` object.
  ///
  /// - Throws: `MCatalogError.notFound`: If the station with the specified ID is not found in the catalog.
  static func getRating(for station: Station) async throws -> Rating {
    let id = station.id
    let request = MCatalogRatingRequest(for: id, item: .station)
    let response = try await request.response()

    guard let rating = response.data.first else {
      throw MRatingError.notFound(for: id.rawValue)
    }
    return rating
  }

  /// Get the ratings for stations in the catalog.
  ///
  ///  Example:
  ///   ```
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
  static func getRatings(for stations: Stations) async throws -> [Rating] {
    let ids = stations.map { $0.id }
    let request = MCatalogRatingRequest(for: ids, item: .station)
    let response = try await request.response()
    return response.data
  }
}

