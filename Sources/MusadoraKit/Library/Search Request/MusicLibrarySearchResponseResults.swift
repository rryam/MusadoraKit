//
//  MLibrarySearchResponseResults.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 08/09/21.
//



/// The results from the library search request using a search term.
struct MLibrarySearchResponseResults: Decodable {
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
