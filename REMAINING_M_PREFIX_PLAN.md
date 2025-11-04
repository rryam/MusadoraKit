# Remaining M-Prefix Structures Renaming Plan

This document outlines the remaining M-prefixed structures that can be renamed to "Music" prefix for complete naming consistency across the MusadoraKit codebase.

## 📊 Summary Statistics
- **Total structures to rename**: 13
- **Categories**: 6 main groups
- **Estimated impact**: ~50+ file references to update

---

## 🎵 Music Summary Structures
### ✅ MSummaryResponse → MusicSummaryResponse
- **Status**: COMPLETED
- **Location**: `Sources/MusadoraKit/Music Summaries/MusicSummaryResponse.swift`
- **Impact**: ~5-7 references updated

### ✅ MSummaryView → MusicSummaryView
- **Status**: COMPLETED
- **Location**: `Sources/MusadoraKit/Music Summaries/MusicSummaryRequest.swift` (enum within file)
- **Impact**: ~3-5 references updated

---

## 📊 Chart Structures
### MChartResponse → MusicChartResponse
- **Location**: `Sources/MusadoraKit/Catalog/CatalogChart/MChartResponse.swift`
- **Usage**: Response structure for chart API calls
- **References**: Used in `MusicChartRequest.response()` return type and `MusicCharts.results`
- **Impact**: ~3-4 references to update

### MChartItem → MusicChartItem
- **Location**: `Sources/MusadoraKit/Catalog/CatalogChart/MChartItem.swift`
- **Usage**: Protocol for chart item types
- **References**: Protocol conformance in chart-related structures
- **Impact**: ~2-3 references to update

---

## 💡 Recommendation Structures
### MRecommendationResponse → MusicRecommendationResponse
- **Location**: `Sources/MusadoraKit/Recommendations/MRecommendationResponse.swift`
- **Usage**: Response structure for recommendation API calls
- **References**: Used in `MusicRecommendationRequest.response()` return type
- **Impact**: ~2-3 references to update

### MRecommendationItem → MusicRecommendationItem
- **Location**: `Sources/MusadoraKit/Recommendations/MRecommendationItem.swift`
- **Usage**: Data structure for individual recommendation items
- **References**: Used in recommendation response structures and related logic
- **Impact**: ~4-6 references to update

### MRecommendationMusicItem → MusicRecommendationMusicItem
- **Location**: `Sources/MusadoraKit/Recommendations/MRecommendationMusicItem.swift`
- **Usage**: Protocol for music items that can be recommended
- **References**: Protocol conformance across music item types
- **Impact**: ~5-7 references to update

---

## 📚 Library Structures
### MLibraryPlaylist → MusicLibraryPlaylist
- **Location**: `Sources/MusadoraKit/Library/MLibraryPlaylist.swift`
- **Usage**: Data structure for library playlists
- **References**: Used throughout library playlist functionality
- **Impact**: ~10-15 references to update

### MLibraryPlaylistPlayParameters → MusicLibraryPlaylistPlayParameters
- **Location**: `Sources/MusadoraKit/Library/MLibraryPlaylist.swift` (nested struct)
- **Usage**: Play parameters for library playlists
- **References**: Used in playlist play functionality
- **Impact**: ~3-5 references to update

---

## 🏪 Storefront Structure
### MStorefront → MusicStorefront
- **Location**: `Sources/MusadoraKit/MStorefront.swift`
- **Usage**: Data structure for Apple Music storefront information
- **References**: Used in storefront lookup and display functionality
- **Impact**: ~8-12 references to update

---

## 🔍 Search Structure
### MCatalogSearchType → MusicCatalogSearchType
- **Location**: `Sources/MusadoraKit/Catalog/MCatalogSearchType.swift`
- **Usage**: Enumeration for catalog search types
- **References**: Used in catalog search functionality
- **Impact**: ~6-8 references to update

---

## ➕ Resource Management Structure
### MAddResourcesRequest → MusicAddResourcesRequest
- **Location**: `Sources/MusadoraKit/Add Resources/MAddResourcesRequest.swift`
- **Usage**: Request structure for adding resources to library
- **References**: Used in `MLibrary+Album.swift`, `MLibrary+Song.swift`, `MLibrary+Playlist.swift`
- **Impact**: ~6-8 references to update

---

## 🕒 Recently Added Structures
### MRecentlyAddedRequest → MusicRecentlyAddedRequest
- **Location**: `Sources/MusadoraKit/History/MRecentlyAddedRequest.swift`
- **Usage**: Request structure for recently added items
- **References**: Used in recently added functionality
- **Impact**: ~3-5 references to update

### MRecentlyAddedResponse → MusicRecentlyAddedResponse
- **Location**: `Sources/MusadoraKit/History/MRecentlyAddedRequest.swift` (nested struct)
- **Usage**: Response structure for recently added items
- **References**: Used in recently added response handling
- **Impact**: ~2-4 references to update

---

## 🌐 URL Components Protocol
### MURLComponents → MusicURLComponents
- **Location**: `Sources/MusadoraKit/Models/AppleMusicURLComponents.swift`
- **Usage**: Protocol for URL component construction
- **References**: Protocol conformance in URL building utilities
- **Impact**: ~2-3 references to update

---

## 🎯 Implementation Strategy

### Phase 1: Music Summary Structures (2 structures)
1. Rename `MSummaryResponse` and `MSummaryView`
2. Update references in summary-related files
3. Test music summary functionality

### Phase 2: Chart Structures (2 structures)
1. Rename `MChartResponse` and `MChartItem`
2. Update references in chart-related files
3. Test chart functionality

### Phase 3: Recommendation Structures (3 structures)
1. Rename `MRecommendationResponse`, `MRecommendationItem`, `MRecommendationMusicItem`
2. Update references in recommendation-related files
3. Test recommendation functionality

### Phase 4: Library Structures (2 structures)
1. Rename `MLibraryPlaylist` and `MLibraryPlaylistPlayParameters`
2. Update references in library-related files
3. Test library functionality

### Phase 5: Remaining Structures (4 structures)
1. Rename `MStorefront`, `MCatalogSearchType`, `MAddResourcesRequest`, `MRecentlyAddedRequest`, `MRecentlyAddedResponse`, `MURLComponents`
2. Update references across the codebase
3. Test all functionality

### Quality Assurance
- Run full test suite after each phase
- Run SwiftLint after each phase
- Verify API compatibility is maintained
- Update documentation as needed

---

## ⚠️ Important Notes

1. **API Compatibility**: All renames must maintain backwards compatibility
2. **Testing**: Each phase should be thoroughly tested before proceeding
3. **Documentation**: Update all documentation comments to reflect new names
4. **Git Commits**: Use descriptive commit messages for each phase
5. **Dependencies**: Some structures may have interdependencies that need careful handling

---

## 📈 Expected Timeline

- **Total estimated time**: 2-3 hours
- **Per phase**: 20-30 minutes
- **Testing overhead**: 10-15 minutes per phase
- **Risk level**: Low (internal structures, well-tested codebase)

---

*This plan ensures systematic completion of the M-prefix renaming project for full naming consistency across MusadoraKit.*
