# Agents Guide

This guide provides context for automation or coding agents (Claude, GPT, etc.) when working with the MusadoraKit repository.

## Project Overview

MusadoraKit is a Swift package that simplifies working with Apple's MusicKit and Apple Music API. It provides high-level abstractions over MusicKit for catalog access, library management, recommendations, and more.

**Key characteristics:**
- Swift 6.0+ with strict concurrency enabled
- Multi-platform: iOS 15+, macOS 12+, watchOS 8+, tvOS 15+, visionOS 1+
- Zero dependencies (except swift-docc-plugin for documentation)
- Pure Swift package with no Objective-C

## Architecture

The codebase exposes a **facade-style API** through stateless structs with static methods:

1. **MCatalog** – Catalog operations (search, charts, storefronts, ratings, favorites, etc.)
2. **MLibrary** – User's library operations (fetch, search, add/remove content, ratings)
3. **MRecommendation** – Recommendations (default sets, 100 Best Albums utilities)
4. **MHistory** – Historical data (recently played, recently added)

Rating-related functionality now lives in the `Ratings/` module via extensions on `MCatalog` and `MLibrary`; there is no standalone `MRating` facade.

The main `MusadoraKit` struct is rarely used directly except for:
- `MusadoraKit.test()` - API connectivity testing
- `MusadoraKit.userToken` - User token storage

**Directory structure:**
```
Sources/MusadoraKit/
├── 100BestAlbums/     - Apple Music “100 Best Albums” helpers
├── Catalog/           - Catalog resource access and search
├── Library/           - Library resource access, search, and management
├── Recommendations/   - Recommendation system integration
├── History/           - Recently played/added history
├── Ratings/           - Rating CRUD operations
├── Favorites/         - Favorites management
├── MusicSummaries/    - Apple Music Replay data
├── MusicPlayer/       - ApplicationMusicPlayer extensions
├── Equivalents/       - Cross-storefront and clean equivalents
├── AddResources/      - Library add operations (playlists, tracks)
├── MultipleResources/ - Batch resource requests
├── MusicItemProperties/ - Typed property collections for MusicKit resources
├── Requests/          - Custom API request types
├── Models/            - Data models and API components
├── Extension/         - MusicKit type extensions
├── Views/             - SwiftUI views (AnimatedArtworkView)
├── MusicItems/        - MusicKit item type extensions
├── Documentation.docc/ - DocC catalog
├── MusadoraKit.swift  - Package entry point
├── MusicRequest.swift - Shared request utilities
├── MusicStorefront.swift  - Storefront helpers and ID mapping
└── PrivacyInfo.xcprivacy
```

**API Request Pattern:**
- Uses `AppleMusicURLComponents` for URL construction
- `MusicDataRequest` for raw API calls
- Custom request types inherit from `MusicDataRequest`
- All async/await with error throwing

## Commands

### Building
```bash
swift build
```

### Testing
```bash
# Run all tests
swift test

# Run tests on specific platform (via xcodebuild)
xcodebuild test -scheme MusadoraKit -destination 'platform=iOS Simulator,name=iPhone 17'
```

- The test suite uses the Swift Testing framework (`@Suite`, `@Test`, `#expect`). Ensure you are on Swift 6.2+ when running or updating tests.

### Multi-platform builds
```bash
# Build for all platforms (from codemagic.yaml)
xcodebuild build -scheme MusadoraKit -destination 'platform=iOS Simulator,name=iPhone 17'
xcodebuild build -scheme MusadoraKit -destination 'platform=macOS'
xcodebuild build -scheme MusadoraKit -destination 'platform=watchOS Simulator,name=Apple Watch Ultra 2 (49mm)'
xcodebuild build -scheme MusadoraKit -destination 'platform=tvOS Simulator,name=Apple TV 4K (3rd generation)'
xcodebuild build -scheme MusadoraKit -destination 'platform=visionOS Simulator,name=Apple Vision Pro'
```

### Linting
```bash
# Project uses SwiftLint with extensive opt-in rules
swiftlint lint

# Run SwiftLint with strict mode after every feature implementation
swiftlint lint --strict
```

### Documentation
```bash
# Generate DocC documentation
swift package generate-documentation

# Preview documentation
swift package --disable-sandbox preview-documentation --target MusadoraKit
```

## Code Conventions

**From .swiftlint.yml:**
- Line length: 300 characters
- Tuple size limit: 3 elements
- Number separators for numbers ≥ 10000
- Sorted imports required
- Extensive rules enabled (see .swiftlint.yml for full list)

**API Design:**
- All public APIs are documented with DocC-style comments
- Methods follow naming pattern: `<resource>(id:)` for single, `<resources>(ids:)` for multiple
- Relationship loading via `with:` parameter accepting array of properties
- Search methods return typed response objects with properties per resource type
- Extensions on MusicKit types (Song, Album, etc.) for additional functionality

**Concurrency:**
- Strict concurrency mode enabled in Package.swift
- All API methods are async/throws
- No @MainActor requirements (library is async-agnostic)

**Error Handling:**
- Uses `MusadoraKitError` enum for custom errors
- Throws URLError for network issues
- MusicKit errors pass through unchanged

## Important Implementation Details

**Resource Relationships:**
MusicKit uses "views" or "relationships" to load related data. When adding methods that fetch resources, check if they support the `with:` parameter for relationship loading (e.g., `song(id:, with: [.albums, .artists])`).

**Storefront Context:**
Many API calls are storefront-specific. Use `MCatalog.storefront(id:)` to fetch a single storefront or `MCatalog.storefronts()` for the full list. Several catalog APIs accept an explicit storefront identifier when regionalization matters.

**Library vs Catalog:**
- Catalog = Apple Music's full catalog (public)
- Library = User's personal collection (requires authorization)
- IDs differ: catalog uses standard IDs, library uses prefixed IDs (e.g., "i.pmzqzM0S2rl5N4L")

**Authentication:**
- Uses MusicKit's built-in authorization (`MusicAuthorization.request()`)
- Developer token handled by MusicKit automatically
- User token optionally stored via `MusadoraKit.userToken` for API calls requiring user context

**Testing Connectivity:**
Always use `MusadoraKit.test()` before making API calls to verify setup.

## Musadora Sample App

The repository includes `Musadora/` directory with a sample iOS app demonstrating MusadoraKit usage. This app shows real-world implementation patterns for:
- Authorization flows
- Catalog browsing
- Library management
- Playing music
- Search functionality
- Recommendation display

Reference this app for usage examples when implementing new features.
