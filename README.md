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
