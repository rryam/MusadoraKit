//
//  HundredBestAlbums.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 20/05/24.
//

import Foundation

extension MRecommendation {
  /// Retrieves the 100 Best Album for a given position.
  ///
  /// Example usage:
  ///
  ///     do {
  ///       let album = try await MRecommendation.hundredBestAlbum(at: 100)
  ///
  ///       print("Album name: \(album.title)")
  ///       print("Artist name: \(album.artistName)")
  ///       // access other album properties as needed
  ///     } catch {
  ///       print("Error retrieving album: \(error.localizedDescription)")
  ///     }
  ///
  /// - Parameters:
  ///   - position: The position of the album in the 100 Best Albums list.
  ///   - storefront: The storefront to fetch the album from (default: "us").
  ///   - region: The region/language code for localization (default: "en-us").
  /// - Returns: The `HundredBestAlbum` object representing the album at the specified position.
  public static func hundredBestAlbum(
    at position: Int, storefront: String = "us", region: String = "en-us"
  ) async throws -> HundredBestAlbum {
    let request = HundredBestAlbumRequest(
      position: position, storefront: storefront, region: region)
    return try await request.response()
  }

  /// Retrieves all the 100 Best Albums using a task group with enumeration.
  ///
  /// Example usage:
  ///
  ///     do {
  ///       let albums = try await MRecommendation.allHundredBestAlbums()
  ///
  ///       for album in albums {
  ///         print("Album name: \(album.title)")
  ///         print("Artist name: \(album.artistName)")
  ///         // access other album properties as needed
  ///       }
  ///     } catch {
  ///       print("Error retrieving albums: \(error.localizedDescription)")
  ///     }
  ///
  /// - Returns: An array of `HundredBestAlbum` objects representing all the 100 Best Albums.
  public static func allHundredBestAlbums(storefront: String = "us", region: String = "en-us")
    async throws -> [HundredBestAlbum]
  {
    let positions = 1...100
    var albums: [HundredBestAlbum?] = Array(repeating: nil, count: positions.count)

    return try await withThrowingTaskGroup(of: (Int, HundredBestAlbum?).self) { group in
      for position in positions {
        group.addTask {
          do {
            let album = try await self.hundredBestAlbum(
              at: position, storefront: storefront, region: region)
            return (position, album)
          } catch {
            return (position, nil)
          }
        }
      }

      for try await (position, album) in group {
        albums[position - 1] = album
      }

      return albums.compactMap { $0 }
    }
  }
}
