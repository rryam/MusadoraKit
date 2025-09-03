# MusadoraKit

The ultimate companion to MusicKit. Working with MusicKit and Apple Music API is much easier, with one-liner APIs.

## What is MusadoraKit?

MusadoraKit is a Swift framework that uses the latest MusicKit and Apple Music API, making it easy to integrate Apple Music into your app. It uses the new async/await pattern introduced in Swift 5.5.

@Metadata {
    @PageKind(article)
    @PageImage(purpose: card, source: "icon.png")
    @CallToAction(
        purpose: primary,
        url: "https://github.com/rryam/MusadoraKit",
        label: "Get Started on GitHub"
    )
}

## Key Features

- Simple one-liner APIs
- Available for iOS 15.0+, macOS 12.0+, watchOS 8.0+ and tvOS 15.0+
- Uses the new async/await pattern introduced in Swift 5.5
- Supports iOS 17, macOS 14, watchOS 10, tvOS 17 and visionOS 1.0
- Works well with SwiftUI

## Quick Start

```swift
import MusadoraKit

// Get user's Apple Music library
let songs = try await MLibrary.songs()

// Search the Apple Music catalog
let results = try await MCatalog.search(for: "The Weeknd", types: [.songs, .albums])

// Get personalized recommendations
let recommendations = try await MRecommendation.default()

// Access user's music summaries (Replay)
let summary = try await MSummary.latest()
```

## API Overview

### Core APIs

- **Catalog** - Search and browse Apple Music catalog
- **Library** - Access user's personal music library
- **Recommendations** - Personalized music suggestions
- **History** - Recently played items

### Music Features

- **Music Player** - Easy playback controls
- **Music Summaries** - Apple Music Replay data
- **Ratings** - Rate and manage music content
- **Favorites** - Manage favorite items
- **Storefronts** - Regional content management

### Other Features

- **Equivalents** - Clean/explicit content versions
- **Batch Requests** - Multiple resources in one request
- **AnimatedArtworkView** - SwiftUI components

## Why MusadoraKit?

**Before MusadoraKit:**
```swift
// Complex async operations
let request = MusicCatalogSearchRequest(term: "Taylor Swift", types: [Song.self])
let response = try await request.response()
let songs = response.songs
```

**With MusadoraKit:**
```swift
// Simple one-liner
let songs = try await MCatalog.search(for: "Taylor Swift", types: [.songs]).songs
```

## Learn More

- **API Reference** - Complete API documentation (auto-generated)
- **<doc:table-of-contents>** - Step-by-step tutorials
- **[Book: Exploring MusicKit](https://academy.rudrank.com/product/musickit)** - Comprehensive guide
- **[Discord Community](https://discord.gg/6KaKCKds)** - Get help and share ideas
- **[Sample Apps](https://github.com/rryam/Musadora)** - Real-world examples

## Apps Using MusadoraKit

- [Music Mate](https://apps.apple.com/app/musicmate-music-map-friends/id1605379758): Meet music friends on the world map.
- [Sonar](https://apps.apple.com/ca/app/sonar-music-community/id1626147292): Music & Community. Stream, Share & Discover
- [Tuneder](https://apps.apple.com/us/app/tuneder-song-discovery/id6450867856?itsct=apps_box_badge&itscg=30200): An open-source iOS app that helps Apple Music users discover new songs with a Tinder-like UI.
- Musadora: Apple Music client focused on playlists
- Musadora Labs: A companion app to explore MusicKit
- Euphonic: Apple Music client focused on recommendations
- [bijou.fm](https://apps.apple.com/app/bijou-fm/id6450460066?platform=iphone): Last.fm client with Apple Music integration

## Getting Started

Follow the steps below to setup MusicKit for your app:

1. Enable MusicKit for your Bundle Identifier in the Apple Developer Portal
2. Add `NSAppleMusicUsageDescription` to your `Info.plist`
3. Request authorization using `MusicAuthorization.request()`
4. Install MusadoraKit via Swift Package Manager

---

Made with love for the Apple Music developer community
