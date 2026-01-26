import Foundation
@testable import MusadoraKit
import MusicKit
import Testing

@Suite
struct LibraryResourceEndpointTests {
  @Test
  func songResourceEndpointIncludesDefaultFields() throws {
    let request = MusicLibraryResourceRequest<Song>()
    let url = try request.libraryEndpointURL

    #expect(url.absoluteString.starts(with: "https://api.music.apple.com/v1/me/library/songs"))

    let items = try queryItems(from: url)
    #expect(items["fields[albums]"] == "artistName,artistUrl,artwork,contentRating,editorialArtwork,name,playParams,releaseDate,url")
    #expect(items["fields[artists]"] == "name,url")
    #expect(items["includeOnly"] == "catalog,artists")
    #expect(items["include[albums]"] == "artists")
    #expect(items["include[library-albums]"] == "artists")
    #expect(items["limit"] == nil)
    #expect(items["ids"] == nil)
  }

  @Test
  func albumResourceEndpointIncludesIdsAndLimit() throws {
    var request = MusicLibraryResourceRequest<Album>(matching: \.id, equalTo: MusicItemID("42"))
    request.limit = 5
    let url = try request.libraryEndpointURL

    #expect(url.absoluteString.starts(with: "https://api.music.apple.com/v1/me/library/albums"))

    let items = try queryItems(from: url)
    #expect(items["ids"] == "42")
    #expect(items["limit"] == "5")
  }

  @Test
  func libraryPlaylistsLimitEndpointIncludesLimitQuery() throws {
    let url = try MLibrary.libraryPlaylistsURL(limit: 10)
    let concreteURL = try #require(url)
    let items = try queryItems(from: concreteURL)
    #expect(items["limit"] == "10")
  }

  @Test
  func libraryPlaylistsURLRequiresPositiveLimit() throws {
    let url = try MLibrary.libraryPlaylistsURL(limit: 0)
    #expect(url == nil)
  }

  @Test
  func libraryResourceEndpointWithEmptyIdsThrows() throws {
    let ids: [MusicItemID] = []
    let request = MusicLibraryResourceRequest<Album>(matching: \.id, memberOf: ids)

    let error = #expect(throws: MusadoraKitError.self) {
      try request.libraryEndpointURL
    }

    #expect(error == MusadoraKitError.idMissing)
  }

  private func queryItems(from url: URL) throws -> [String: String] {
    guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
          let queryItems = components.queryItems else {
      throw URLError(.badURL)
    }

    return queryItems.reduce(into: [:]) { result, item in
      result[item.name] = item.value
    }
  }
}
