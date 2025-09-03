# MusadoraKit

The ultimate companion to MusicKit - working with Apple's Music APIs has never been easier!

## 🎵 What is MusadoraKit?

MusadoraKit is a Swift framework that provides simple, powerful APIs for Apple's MusicKit and Apple Music API. It transforms complex async/await patterns into one-liner methods, making music integration effortless.

@Metadata {
    @PageKind(article)
    @PageImage(purpose: card, source: "icon.png")
    @CallToAction(
        purpose: primary,
        url: "https://github.com/rryam/MusadoraKit",
        label: "Get Started on GitHub"
    )
}

## ✨ Key Features

| Feature | Description |
|---------|-------------|
| 🎯 **One-liner APIs** | Simple async methods for complex operations |
| 📱 **Cross-platform** | iOS 15+, macOS 12+, watchOS 8+, tvOS 15+, visionOS 1+ |
| 🔄 **Latest async/await** | Modern Swift concurrency patterns |
| 📚 **Complete coverage** | All MusicKit APIs + Apple Music API extensions |
| 🎨 **SwiftUI ready** | Perfect for modern app development |

## 🚀 Quick Start

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

## 📋 Table of Contents

### Core APIs

- **[Catalog](MCatalog)** - Search and browse Apple Music catalog
- **[Library](MLibrary)** - Access user's personal music library
- **[Search](Searching-the-Catalog)** - Advanced search capabilities
- **[Recommendations](MRecommendation)** - Personalized music suggestions

### Enhanced Features

- **[Music Player](Music-Player)** - Convenient playback controls
- **[Music Summaries](Music-Summaries-Replay)** - Apple Music Replay data
- **[Ratings](Ratings)** - Rate and manage music content
- **[100 Best Albums](100-Best-Albums)** - Curated album collections
- **[Favorites](Favorites)** - Manage favorite items
- **[Storefronts](Storefronts)** - Regional content management

### Advanced Features

- **[Equivalents](Equivalents)** - Clean/explicit content versions
- **[Resources](Multiple-Resources)** - Batch API requests
- **[AnimatedArtworkView](AnimatedArtworkView)** - SwiftUI components

## 🎯 Why MusadoraKit?

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

## 📚 Learn More

- **API Reference** - Complete API documentation (auto-generated)
- **[Book: Exploring MusicKit](https://rudrank.gumroad.com/l/musickit)** - Comprehensive guide
- **[Discord Community](https://discord.gg/6KaKCKds)** - Get help and share ideas
- **[Sample Apps](https://github.com/rryam/Musadora)** - Real-world examples

## 🏆 Apps Using MusadoraKit

- **Music Mate** - Meet music friends worldwide
- **Sonar** - Music & community streaming
- **Tuneder** - Tinder-like music discovery
- **Musadora** - Feature-rich music client
- **Euphonic** - Recommendation-focused player
- **bijou.fm** - Last.fm integration

## 🔧 Getting Started

1. **Enable MusicKit** in your Apple Developer account
2. **Add permissions** to your app's Info.plist
3. **Request authorization** using MusicKit
4. **Install MusadoraKit** via Swift Package Manager
5. **Start building** amazing music experiences!

---

*Made with ❤️ for the Apple Music developer community*
