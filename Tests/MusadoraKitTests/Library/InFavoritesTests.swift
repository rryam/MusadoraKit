import Foundation
@testable import MusadoraKit
import MusicKit
import Testing

@Suite
struct InFavoritesTests {
  // MARK: - Song Tests

  @Test
  func songInFavoritesParsesTrueCorrectly() throws {
    let json = """
    {
      "data": [{
        "id": "1234",
        "type": "songs",
        "attributes": {
          "name": "Test Song",
          "inFavorites": true
        },
        "relationships": {
          "library": {
            "data": [{"id": "i.abc123", "type": "library-songs"}]
          }
        }
      }]
    }
    """

    let data = try #require(json.data(using: .utf8))
    let inFavorites = try InFavoritesParser.parse(from: data, itemType: .songs)

    #expect(inFavorites == true)
  }

  @Test
  func songInFavoritesParsesFalseCorrectly() throws {
    let json = """
    {
      "data": [{
        "id": "1234",
        "type": "songs",
        "attributes": {
          "name": "Test Song",
          "inFavorites": false
        },
        "relationships": {
          "library": {
            "data": [{"id": "i.abc123", "type": "library-songs"}]
          }
        }
      }]
    }
    """

    let data = try #require(json.data(using: .utf8))
    let inFavorites = try InFavoritesParser.parse(from: data, itemType: .songs)

    #expect(inFavorites == false)
  }

  @Test
  func songNotInLibraryReturnsFalse() throws {
    let json = """
    {
      "data": [{
        "id": "1234",
        "type": "songs",
        "attributes": {
          "name": "Test Song",
          "inFavorites": false
        },
        "relationships": {
          "library": {
            "data": []
          }
        }
      }]
    }
    """

    let data = try #require(json.data(using: .utf8))
    let inFavorites = try InFavoritesParser.parse(from: data, itemType: .songs)

    #expect(inFavorites == false)
  }

  // MARK: - Album Tests

  @Test
  func albumInFavoritesParsesTrueCorrectly() throws {
    let json = """
    {
      "data": [{
        "id": "1234",
        "type": "albums",
        "attributes": {
          "name": "Test Album",
          "inFavorites": true
        },
        "relationships": {
          "library": {
            "data": [{"id": "i.xyz789", "type": "library-albums"}]
          }
        }
      }]
    }
    """

    let data = try #require(json.data(using: .utf8))
    let inFavorites = try InFavoritesParser.parse(from: data, itemType: .albums)

    #expect(inFavorites == true)
  }

  // MARK: - Artist Tests

  @Test
  func artistInFavoritesParsesTrueCorrectly() throws {
    let json = """
    {
      "data": [{
        "id": "1234",
        "type": "artists",
        "attributes": {
          "name": "Test Artist",
          "inFavorites": true
        },
        "relationships": {
          "library": {
            "data": [{"id": "i.def456", "type": "library-artists"}]
          }
        }
      }]
    }
    """

    let data = try #require(json.data(using: .utf8))
    let inFavorites = try InFavoritesParser.parse(from: data, itemType: .artists)

    #expect(inFavorites == true)
  }

  // MARK: - Playlist Tests

  @Test
  func playlistInFavoritesParsesTrueCorrectly() throws {
    let json = """
    {
      "data": [{
        "id": "pl.123",
        "type": "playlists",
        "attributes": {
          "name": "Test Playlist",
          "inFavorites": true
        },
        "relationships": {
          "library": {
            "data": [{"id": "pl.u-abc", "type": "library-playlists"}]
          }
        }
      }]
    }
    """

    let data = try #require(json.data(using: .utf8))
    let inFavorites = try InFavoritesParser.parse(from: data, itemType: .playlists)

    #expect(inFavorites == true)
  }

  // MARK: - Error Case Tests

  @Test
  func missingInFavoritesAttributeThrowsError() throws {
    let json = """
    {
      "data": [{
        "id": "1234",
        "type": "songs",
        "attributes": {
          "name": "Test Song"
        },
        "relationships": {
          "library": {
            "data": [{"id": "i.abc123", "type": "library-songs"}]
          }
        }
      }]
    }
    """

    let data = try #require(json.data(using: .utf8))

    #expect(throws: MusadoraKitError.self) {
      try InFavoritesParser.parse(from: data, itemType: .songs)
    }
  }

  @Test
  func emptyDataArrayThrowsError() throws {
    let json = """
    {
      "data": []
    }
    """

    let data = try #require(json.data(using: .utf8))

    #expect(throws: MusadoraKitError.self) {
      try InFavoritesParser.parse(from: data, itemType: .songs)
    }
  }
}
