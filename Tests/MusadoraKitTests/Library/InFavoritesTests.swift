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

    guard let data = json.data(using: .utf8) else {
      throw Issue.record("Failed to convert JSON string to Data")
    }
    let inFavorites = try InFavoritesParser.parse(from: data, itemType: .song)

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

    guard let data = json.data(using: .utf8) else {
      throw Issue.record("Failed to convert JSON string to Data")
    }
    let inFavorites = try InFavoritesParser.parse(from: data, itemType: .song)

    #expect(inFavorites == false)
  }

  @Test
  func songNotInLibraryThrowsError() throws {
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

    guard let data = json.data(using: .utf8) else {
      throw Issue.record("Failed to convert JSON string to Data")
    }

    #expect(throws: MusadoraKitError.self) {
      try InFavoritesParser.parse(from: data, itemType: .song)
    }
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

    guard let data = json.data(using: .utf8) else {
      throw Issue.record("Failed to convert JSON string to Data")
    }
    let inFavorites = try InFavoritesParser.parse(from: data, itemType: .album)

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

    guard let data = json.data(using: .utf8) else {
      throw Issue.record("Failed to convert JSON string to Data")
    }
    let inFavorites = try InFavoritesParser.parse(from: data, itemType: .artist)

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

    guard let data = json.data(using: .utf8) else {
      throw Issue.record("Failed to convert JSON string to Data")
    }
    let inFavorites = try InFavoritesParser.parse(from: data, itemType: .playlist)

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

    guard let data = json.data(using: .utf8) else {
      throw Issue.record("Failed to convert JSON string to Data")
    }

    #expect(throws: MusadoraKitError.self) {
      try InFavoritesParser.parse(from: data, itemType: .song)
    }
  }

  @Test
  func emptyDataArrayThrowsError() throws {
    let json = """
    {
      "data": []
    }
    """

    guard let data = json.data(using: .utf8) else {
      throw Issue.record("Failed to convert JSON string to Data")
    }

    #expect(throws: MusadoraKitError.self) {
      try InFavoritesParser.parse(from: data, itemType: .song)
    }
  }
}
