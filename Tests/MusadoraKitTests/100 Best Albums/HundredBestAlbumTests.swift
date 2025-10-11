@testable import MusadoraKit
import Testing

@Suite
struct HundredBestAlbumTests {
  @Test
  func hundredBestAlbumAtPosition() async throws {
    let position = 100
    let album = try await MRecommendation.hundredBestAlbum(at: position)

    #expect(album.title == "Body Talk")
    #expect(album.artistName == "Robyn")
    #expect(album.position == "100")
    #expect(album.id == MusicItemID("1440714879"))
  }

  @Test
  func allHundredBestAlbumsContainExpectedEntries() async throws {
    let albums = try await MRecommendation.allHundredBestAlbums()

    let eightyThirdAlbum = try #require(albums.first(where: { $0.position == "83" }))
    #expect(eightyThirdAlbum.title == "Horses ")
    #expect(eightyThirdAlbum.artistName == "Patti Smith")
    #expect(eightyThirdAlbum.position == "83")
    #expect(eightyThirdAlbum.id == MusicItemID("1038568061"))

    let fortyNinthAlbum = try #require(albums.first(where: { $0.position == "49" }))
    #expect(fortyNinthAlbum.title == "The Joshua Tree")
    #expect(fortyNinthAlbum.artistName == "U2")
    #expect(fortyNinthAlbum.position == "49")
    #expect(fortyNinthAlbum.id == MusicItemID("1443155637"))
  }
}
