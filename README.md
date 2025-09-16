# MusadoraKit

MusadoraKit (pronounced 'myu' za' 'do' 'ra') is the ultimate companion to MusicKit. Working with MusicKit and Apple Music API is much easier, with one-liner APIs for effortless implementation.

<p align="center">
  <img src= "https://github.com/rryam/MusadoraKit/blob/main/MusadoraKitIcon.png" alt="MusadoraKit Logo" width="256"/>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Concurrency_Mode-Strict-orange" alt="Concurrency Mode: Strict">
</p>

MusadoraKit is a Swift framework that uses the latest MusicKit and Apple Music API, making it easy to integrate Apple Music into your app. It uses the new async/await pattern introduced in Swift 5.5. Currently, it is available for iOS 15.0+, macOS 12.0+, watchOS 8.0+ and tvOS 15.0+. There are new methods coming every month to support iOS 16, macOS 13, watchOS 9 and tvOS 16 features. The framework now also supports iOS 17, macOS 14, watchOS 10, tvOS 17 and visionOS 1.0.

It goes well with my book on [*Exploring MusicKit and Apple Music API*](https://rudrank.gumroad.com/l/musickit), as all the documentation and references are mentioned in the book. Otherwise, the code itself is well documented.

Also, join the [Discord Community](https://discord.gg/6KaKCKds) for discussing anything about MusadoraKit, the book "Exploring MusicKit", MusicKit or your favorite music!

## Exploring MusicKit and Apple Music API Book 

You can support my open-source by buying my book, ["Exploring MusicKit and Apple Music API"](http://exploringmusickit.com). 2 books a day, and I can happily continue working on MusadoraKit.

## Sponsors

<p align="leading">
  <img src= "https://is3-ssl.mzstatic.com/image/thumb/Purple116/v4/cd/40/fe/cd40fe7c-b0f8-30aa-0b41-4a76e7968766/AppIcon-1x_U007emarketing-0-0-0-10-0-0-85-220.png/246x0w.webp" alt="PlaylistAI Logo" width="64"/>
</p>

[PlaylistAI](https://twitter.com/playlist_ai) by [Brett Bauman](https://twitter.com/brettunhandled)

## [Documentation using DocC](https://rryam.github.io/MusadoraKit/documentation/musadorakit/musadorakit/)

## Musadora Sample App
I am open-sourcing an app I worked on last year called Musadora. (MusadoraKit started as RRMusicKit for the Musadora app!) 

I am slowly adding all the methods used in MusadoraKit to it, so you can refer to how easy it is to use the Swift package.

## Apps Using MusadoraKit

- [Music Mate](https://apps.apple.com/app/musicmate-music-map-friends/id1605379758): Meet music friends on the world map.
- [Sonar](https://apps.apple.com/ca/app/sonar-music-community/id1626147292): Music & Community. Stream, Share & Discover
- [Tuneder](https://apps.apple.com/us/app/tuneder-song-discovery/id6450867856?itsct=apps_box_badge&itscg=30200): An [open-source](https://github.com/adityasaravana/Tuneder) iOS app that helps Apple Music users discover new songs with a Tinder-like UI.
- Musadora: Apple Music client focused on playlists
- Musadora Labs: A companion app to explore MusicKit
- Euphonic: Apple Music client focused on recommendations
- [bijou.fm](https://apps.apple.com/app/bijou-fm/id6450460066?platform=iphone): Last.fm client with Apple Music integration

## Table of Contents

- [Start Working with MusicKit](#start-working-with-musickit)
  - [Step 1: Enable MusicKit for Your Bundle Identifier](#step-1-enable-musickit-for-your-bundle-identifier)
  - [Step 2: Add NSAppleMusicUsageDescription to Info.plist](#step-2-add-nsapplemusicusagedescription-to-infoplist)
  - [Step 3: Request Authorization for Apple Music](#step-3-request-authorization-for-apple-music)
- [Testing Connectivity](#testing-connectivity)
- [Core APIs](#core-apis)
  - [Catalog](#catalog)
  - [Searching the Catalog](#searching-the-catalog)
  - [Library](#library)
  - [Recommendations](#recommendations)
  - [History](#history)
- [Enhanced Features](#enhanced-features)
  - [Music Player](#music-player)
  - [Music Summaries (Replay)](#music-summaries-replay)
  - [Ratings](#ratings)
  - [100 Best Albums](#100-best-albums)
  - [Favorites](#favorites)
- [Advanced Features](#advanced-features)
  - [Storefronts](#storefronts)
  - [Referencing content across different geographical regions](#referencing-content-across-different-geographical-regions)
  - [Explicit to clean-equivalent content](#explicit-to-clean-equivalent-content)
  - [MusicCatalogResourcesRequest](#musiccatalogresourcesrequest)
  - [MusicLibraryResourcesRequest](#musiclibraryresourcesrequest)
  - [Animated Artwork View](#animated-artwork-view)

## Start Working with MusicKit 
Follow the steps below to setup MusicKit for your app:

### Step 1: Enable MusicKit for Your Bundle Identifier
1. Visit the [Apple Developer Portal](https://developer.apple.com/account).
2. Navigate to `Certificates, Identifiers & Profiles`.
3. Select `Identifiers` from the left panel.
4. Find your App's Bundle Identifier from the list and select it.
5. Under `Services`, ensure `MusicKit` is enabled. If not, enable it.

### Step 2: Add `NSAppleMusicUsageDescription` to `Info.plist`
To inform the user why your app requires access to their media library, add `NSAppleMusicUsageDescription` to your `Info.plist` file.
1. Open your project in Xcode.
2. Select `Info.plist` from the Project Navigator.
3. Click on the `+` button to add a new key.
4. Add `NSAppleMusicUsageDescription` as a key.
5. Set its value to the reason why your app needs access to Apple Music, e.g., `Our app uses Music access to play music and create a pleasant experience.`.

### Step 3: Request Authorization for Apple Music
Before your app can interact with Apple Music, it needs to request the user's authorization. This can be done using `MusicAuthorization.request()`. 

Here's a Swift code example:

```swift
import MusicKit

class MusicAuthorizationManager: ObservableObject {
    @Published var isAuthorizedForMusicKit = false
    @Published var musicKitError: MusicKitError?

    func requestMusicAuthorization() async {
        let status = await MusicAuthorization.request()

        switch status {
        case .authorized:
            isAuthorizedForMusicKit = true
        case .restricted:
            musicKitError = .restricted
        case .notDetermined:
            musicKitError = .notDetermined
        case .denied:
            musicKitError = .denied
        @unknown default:
            musicKitError = .notDetermined
        }
    }
}
```

This `MusicAuthorizationManager` class checks the authorization status for MusicKit. If the user grants authorization, `isAuthorizedForMusicKit` is set to `true`. If access is denied or restricted, or if the status is not determined, an appropriate `MusicKitError` is set.

Remember to call `requestMusicAuthorization()` at an appropriate time in your application flow to request the user's authorization.

## Testing Connectivity

Test your Apple Music API setup and developer token validity with a simple connectivity check.

### Basic connectivity test:

```swift
Task {
    do {
        try await MusadoraKit.testConnectivity()
        print("Successfully connected to Apple Music API!")
    } catch {
        print("Failed to connect: \(error.localizedDescription)")

        // Check for specific error types
        if let urlError = error as? URLError {
            switch urlError.code {
            case .userAuthenticationRequired:
                print("Issue with developer token or MusicKit setup")
            case .badServerResponse:
                print("Server error - check your configuration")
            default:
                print("Network or other error")
            }
        }
    }
}
```

This method performs a GET request to Apple's test endpoint and validates:
- Developer token is valid
- MusicKit capabilities are properly configured
- Network connectivity to Apple Music API
- Basic API communication works

## Catalog 

To easily access the Apple Music Catalog, you can use pre-defined methods from MusadoraKit. The methods are similar across the music items. 

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

## Music Player

Convenient extensions for Apple's ApplicationMusicPlayer to easily play songs, albums, playlists, and stations with simple one-liner methods.

### Play songs and albums:

```swift
// Play a single song
try await player.play(song: song)

// Play multiple songs
try await player.play(songs: songs)

// Play an album
try await player.play(album: album)

// Play a playlist
try await player.play(playlist: playlist)
```

### Play with position control:

```swift
// Insert and play a song at a specific position in queue
try await player.play(song: song, at: .afterCurrentEntry)

// Play a personalized recommendation item
try await player.play(item: musicPersonalRecommendation)
```

### Play stations and music videos:

```swift
// Play a radio station
try await player.play(station: station)

// Play a music video (available on iOS 16+, tvOS 16+)
try await player.play(musicVideo: musicVideo)
```

## Music Summaries (Replay)

You can also fetch your users' Apple Music Replay data. It is limited to their yearly music summary for the latest year. It will return their top artists, albums, and songs all in one request.

### Fetch complete summary:

```swift
let summary = try await MSummary.latest()

print(summary.topArtists)
print(summary.topAlbums)
print(summary.topSongs)
```

### Fetch specific categories:

```swift
// Get only top artists
let topArtists = try await MSummary.latestTopArtists()

// Get only top albums
let topAlbums = try await MSummary.latestTopAlbums()

// Get only top songs
let topSongs = try await MSummary.latestTopSongs()
```

### Customize with specific views:

```swift
// Get only top artists and albums (skip songs)
let summary = try await MSummary.latest(views: [.topArtists, .topAlbums])
```

## Ratings

Add, retrieve, and manage ratings for your users' favorite Apple Music content. Support for songs, albums, playlists, music videos, and stations.

### Add ratings:

```swift
// Rate a song as "liked"
let rating = try await MCatalog.addRating(for: song, rating: .like)

// Rate an album as "disliked"
let rating = try await MCatalog.addRating(for: album, rating: .dislike)

// Rate a playlist
let rating = try await MCatalog.addRating(for: playlist, rating: .love)
```

### Get current ratings:

```swift
// Get rating for a song
let rating = try await MCatalog.rating(for: song)

// Get rating for an album
let rating = try await MCatalog.rating(for: album)
```

### Remove ratings:

```swift
// Remove rating from a song
try await MCatalog.deleteRating(for: song)

// Remove rating from a playlist
try await MCatalog.deleteRating(for: playlist)
```

### Available rating types:
- `.like` - Like content
- `.dislike` - Dislike content
- `.love` - Love content (hearted)

## 100 Best Albums

Access Apple's curated collection of the 100 Best Albums of all time. Get individual albums by position or fetch the entire collection.

### Get a specific album:

```swift
// Get the #1 album
let album = try await MRecommendation.hundredBestAlbum(at: 1)
print("Top album: \(album.title) by \(album.artistName)")
```

### Get all 100 albums:

```swift
// Get the complete collection
let allAlbums = try await MRecommendation.allHundredBestAlbums()

for album in allAlbums {
    print("\(album.title) - \(album.artistName)")
}
```

### With custom storefront:

```swift
// Get albums for a specific region
let albums = try await MRecommendation.allHundredBestAlbums(storefront: "gb")
```

## Favorites

Add songs, albums, playlists, artists, music videos, and stations to your users' Apple Music favorites.

### Add to favorites:

```swift
// Favorite a song
let success = try await MCatalog.favorite(song: song)

// Favorite an album
let success = try await MCatalog.favorite(album: album)

// Favorite a playlist
let success = try await MCatalog.favorite(playlist: playlist)

// Favorite an artist
let success = try await MCatalog.favorite(artist: artist)
```

### Favorite a music video:

```swift
let success = try await MCatalog.favorite(musicVideo: musicVideo)
```

### Favorite a station:

```swift
let success = try await MCatalog.favorite(station: station)
```

## Storefronts

Access Apple Music storefront information and manage regional content availability.

### Get all available storefronts:

```swift
let storefronts = try await MCatalog.storefronts()

for storefront in storefronts {
    print("\(storefront.name) (\(storefront.id))")
}
```

### Get a specific storefront:

```swift
let usStorefront = try await MCatalog.storefront(id: "us")
print("US Storefront: \(usStorefront.name)")
```

### Get current storefront:

```swift
let current = try await MStorefront.current()
print("Current region: \(current.id)")
```

## Referencing content across different geographical regions

In the example below, the target storefront is "jp" for Japan:

```swift
let album = MCatalog.album(id: "1223618217")
let equivalentAlbum = try await album.equivalent(for: "jp")

let albums = MCatalog.albums(ids: ["1223618217", "1603171516"])
let equivalentAlbums = try await albums.equivalents(for: "jp")
```

## Explicit to clean-equivalent content:

```swift
let song = MCatalog.song(id: "1603171970")
let cleanSong = try await song.clean

let songs = MCatalog.songs(ids: ["1603171970", "1531327246"])
let cleanSongs = try await songs.clean
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

## Animated Artwork View

Create stunning animated backgrounds from music artwork with dynamic mesh gradients. Available on iOS 18, macOS 15, watchOS 11, tvOS 18, and visionOS 2 or later.

### Basic usage:

```swift
struct ContentView: View {
    @ObservedObject private var queue = ApplicationMusicPlayer.shared.queue

    var body: some View {
        AnimatedArtworkView(queue: queue)
            .ignoresSafeArea()
    }
}
```

### With custom artwork:

```swift
AnimatedArtworkView(
    queue: ApplicationMusicPlayer.shared.queue,
    artwork: customArtwork,
    width: 400,
    height: 400
)
```

### Custom gradient points:

```swift
let customPoints: [SIMD2<Float>] = [
    SIMD2<Float>(0.0, 0.0), SIMD2<Float>(0.5, 0.0), SIMD2<Float>(1.0, 0.0),
    SIMD2<Float>(0.0, 0.5), SIMD2<Float>(0.8, 0.2), SIMD2<Float>(0.2, 0.8),
    SIMD2<Float>(1.0, 0.5), SIMD2<Float>(0.0, 1.0), SIMD2<Float>(0.5, 1.0),
    SIMD2<Float>(1.0, 1.0), SIMD2<Float>(0.3, 0.7), SIMD2<Float>(0.7, 0.3),
    SIMD2<Float>(0.1, 0.9), SIMD2<Float>(0.9, 0.1), SIMD2<Float>(0.4, 0.6),
    SIMD2<Float>(0.6, 0.4)
]

AnimatedArtworkView(
    queue: queue,
    points: customPoints
)
```

This view automatically extracts dominant colors from the current playing song's artwork and creates a beautiful animated mesh gradient background that responds to the music.

I hope you love working with MusadoraKit!

> To my future self, and to every developer whose life my code may touch:  
I just have a lot to write, and will keep writing until the end, hoping to leave something good behind.
