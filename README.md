# MusadoraKit

<p align="center">
  <img src= "https://github.com/rryam/MusadoraKit/blob/main/MusadoraKitIcon.png" alt="MusadoraKit Logo" width="256"/>
</p>

MusadoraKit is a Swift framework that uses the latest MusicKit and Apple Music API, making it easy to integrate Apple Music into your app. It uses the new async/await pattern introduced in Swift 5.5. Currently, it is available for iOS 15.0+, macOS 12.0+, watchOS 8.0+ and tvOS 15.0+.

It goes well with my book on [*Exploring MusicKit*](http://exploringmusickit.com), as all the documentation and references are mentioned in the book. Otherwise, the code itself is well documented.

Example: 

```swift 
class ExampleViewModel: ObservableObject {
    @Published private(set) var song: Song?

    func getSong() async {
        do {
            /// MusicKit
            var request = MusicCatalogResourceRequest<Song>(matching: \.id, equalTo: "1613834774")
            request.properties = [.musicVideos, .albums]

            let response = try await request.response()

            guard let song = response.items.first else { return }

            self.song = song

            /// MusadoraKit
            self.song = try await MusadoraKit.catalogSong(id: "1613834774", with: [.musicVideos, .albums])
        } catch {
            print(error)
        }
    }
}
```

# MusicLibrarySearchRequest

`MusicLibrarySearchRequest` is a request that your app uses to fetch items from your library catalog using a search term.

It is similar to the `MusicCatalogSearchRequest` that is used for searching the Apple Music catalog instead.

You initialize the structure by providing the search term and the list of searchable types. It creates a library search request for it.

```swift
init(term: String, types: [MusicLibrarySearchable.Type])
```

Note that `term` and `types` are **required** properties.

There are two optional properties -
- `limit` for the number of items to return in the library search response. The default number is 5 with a maximum value of 25.
- `offset` to create an offset for the request.

`MusicLibrarySearchRequest` also contains an instance method `response()` that returns the `MusicLibrarySearchResponse`. This response fetches items of the requested library searchable types that match the search term of the request.

The library searchable types are -
- Song
- Artist
- Album
- MusicVideo
- Playlist

Based on the response, you get the `MusicItemCollection` for the requested music items.

## Example

```swift
let request = MusicLibrarySearchRequest(term: "the weeknd", types: [Artist.self, Song.self])
let response = try await request.response()

print(response.songs)
print(response.artists)
```
