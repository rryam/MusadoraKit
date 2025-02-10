//
//  MLibraryPlaylistFolder.swift
//
//
//  Created by Rudrank Riyam on 26/12/22.
//

/// A collection of playlist folders from the user's library.
///
/// This type alias represents an array of playlist folders that can be retrieved from
/// the user's Apple Music library. Each folder can contain multiple playlists and
/// can be organized hierarchically.
///
/// Example usage:
/// ```swift
/// do {
///     let folders: LibraryPlaylistFolders = try await MLibrary.playlistFolders()
///     for folder in folders {
///         print("Folder name: \(folder.name)")
///         print("Number of playlists: \(folder.playlists.count)")
///     }
/// } catch {
///     print("Failed to fetch playlist folders: \(error)")
/// }
/// ```
public typealias LibraryPlaylistFolders = [LibraryPlaylistFolder]

extension MLibrary {

  /// Fetches all playlist folders from the user's library.
  ///
  /// This method retrieves the root-level playlist folders from the user's Apple Music library.
  /// Each folder may contain playlists and subfolders.
  ///
  /// Example usage:
  /// ```swift
  /// do {
  ///     let folders = try await MLibrary.rootPlaylistsFolder()
  ///     for folder in folders {
  ///         print("Found folder: \(folder.name)")
  ///     }
  /// } catch {
  ///     print("Error fetching playlist folders: \(error)")
  /// }
  /// ```
  ///
  /// - Returns: An array of `LibraryPlaylistFolder` objects representing the user's playlist folders.
  /// - Throws: An error if the request fails or if the user's authorization status has changed.
 // static func rootPlaylistsFolder() async throws -> LibraryPlaylistFolders {
    // Implementation commented out
//  }
}
