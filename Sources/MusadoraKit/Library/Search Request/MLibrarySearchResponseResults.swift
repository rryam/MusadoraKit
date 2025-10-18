// 
//  MLibrarySearchResponseResults.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 08/09/21.
//

/// The results from the library search request using a search term.
///
/// This structure wraps the search response from the Apple Music API when searching
/// a user's library. It provides access to the search results through its `results` property.
///
/// Example usage:
/// ```swift
/// let request = MLibrarySearchRequest(term: "coldplay", types: [Song.self])
/// let response = try await request.response()
/// let results = MLibrarySearchResponseResults(results: response)
/// print(results.results.songs)
/// ```
struct MLibrarySearchResponseResults: Decodable {
  /// The search response containing collections of different music items.
  var results: MLibrarySearchResponse
}

extension MLibrarySearchResponseResults: CustomStringConvertible, CustomDebugStringConvertible {
  public var description: String {
    var description = "MusicLibrarySearchResponseResults("
    let mirror = Mirror(reflecting: self)

    description += mirror.children.map { "\n\($0.value)," }.joined()

    return description + "\n)"
  }

  public var debugDescription: String {
    "MusicLibrarySearchResponseResults(\n\(results))"
  }
}
