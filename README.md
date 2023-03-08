# MusadoraKit

The ultimate companion to MusicKit.

<p align="center">
  <img src= "https://github.com/rryam/MusadoraKit/blob/main/MusadoraKitIcon.png" alt="MusadoraKit Logo" width="256"/>
</p>

MusadoraKit is a Swift framework that uses the latest MusicKit and Apple Music API, making it easy to integrate Apple Music into your app. It uses the new async/await pattern introduced in Swift 5.5. Currently, it is available for iOS 15.0+, macOS 12.0+, watchOS 8.0+ and tvOS 15.0+. There are new methods coming every month to support iOS 16, macOS 13, watchOS 9 and tvOS 16 features.

It goes well with my book on [*Exploring MusicKit and Apple Music API*](http://exploringmusickit.com), as all the documentation and references are mentioned in the book. Otherwise, the code itself is well documented.

Also, join the [Discord Community](https://discord.gg/6KaKCKds) for discussing anything about MusadoraKit, the book "Exploring MusicKit", MusicKit or your favorite music!

## Support 

You can support my open-source by buying my book, ["Exploring MusicKit and Apple Music API"](http://exploringmusickit.com) or by [buying me a book](https://www.buymeacoffee.com/rudrank)! 

## [Documentation using DocC](https://rryam.github.io/MusadoraKit/documentation/musadorakit/)

## Musadora Sample App
I am open-sourcing an app I worked on last year called Musadora. (MusadoraKit started as RRMusicKit for the Musadora app!) 

I am slowly adding all the methods used in MusadoraKit to it, so you can refer to how easy it is to use the Swift package.

## Apps Using MusadoraKit

- Musadora: Apple Music client focused on playlists
- Musadora Labs: A companion app to explore MusicKit
- Euphonic: Apple Music client focused on recommendations

## Catalog 

To easily access the Apple Music Catalog, you can use pre-defined methods from MusadoraKit. The method are similar across the music items. 

Example of working with fetching a catalog song by its identifier: 

```swift 
let song = try await MCatalog.song(id: "1613834314", with: [.albums])
```

## Searching the Catalog

Example of searching the catalog: 

```swift 
let searchResponse = try await MCatalog.search(for: "the weeknd", types: [.songs, .stations, .albums, .playlists, .artists], limit: 10)

print(searchResponse.songs)
print(searchResponse.artists)
```

## Library 

While this is natively not available in MusicKit, you can fetch library resources using MusadoraKit that uses Apple Music API under the hood. The method are similar across the music items. 

Example of fetching all library songs in alphabetical order: 

```swift 
let songs = try await MLibrary.songs()
```

Example of searching the user's library: 

```swift 
let searchResponse = try await MLibrary.search(for: "hello", types: [Song.self])

print(searchResponse.songs)
```

## Recommendations 

You can take advantage of Apple's Music recommendation system and use it in your app. For example, to fetch the default recommendations: 

```swift 
let recommendations = try await MRecommendation.default()

guard let recommendation = recommendations.first else { return }

print(recommendation.albums)
print(recommendation.playlists)
print(recommendation.stations)
```

## History 

You can also fetch historial data from the user's library. For example, to get the recently played resources: 

```swift 
let recentlyPlayedItems = try await MLibrary.recentlyPlayed()

let recentlyPlayedAlbums = try await MLibrary.recentlyPlayedAlbums()
}
```

## MusicCatalogResourcesRequest: 

To fetch multiple catalog music items by their identifiers in the same request. For example:

```swift 
let request = MusicCatalogResourcesRequest(types: [.songs: ["1456313177"], .albums: ["1531125029", "1575203352"]])
let response = try await request.response()

print(response.songs)
print(response.albums)
```

## MusicLibraryResourcesRequest:

To fetch multiple library music items by their identifiers in the same request. For example:

```swift
let request = MusicLibraryResourcesRequest(types: [.songs: ["i.pmzqzM0S2rl5N4L"], .playlists: ["p.PkxVBgps2zOdV3r"]])
let response = try await request.response()

print(response.songs)
print(response.playlists)
```

I hope you love working with MusadoraKit! 
