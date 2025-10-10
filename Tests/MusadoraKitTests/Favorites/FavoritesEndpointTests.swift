import Testing
import MusicKit
@testable import MusadoraKit

@Suite struct FavoritesEndpointTests {

  @Test func favoriteSingleSongEndpoint() throws {
    let request = MFavoritesRequest(itemID: MusicItemID("123"), resourceType: .songs)
    let url = try request.favoritesEndpointURL
    expectEndpoint(url, equals: "https://api.music.apple.com/v1/me/favorites?ids[songs]=123")
  }

  @Test func favoriteMultipleResourcesEndpoint() throws {
    let ids: [MusicItemID] = ["1", "2", "3"]
    let request = MFavoritesRequest(itemIDs: ids, resourceType: .albums)
    let url = try request.favoritesEndpointURL
    expectEndpoint(url, equals: "https://api.music.apple.com/v1/me/favorites?ids[albums]=1,2,3")
  }
}
