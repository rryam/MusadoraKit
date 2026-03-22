@testable import MusadoraKit
import MusicKit
import SwiftUI
import Testing

@MainActor
@Suite
struct AnimatedArtworkViewTests {
  @available(iOS 18.0, macOS 15.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *)
  @Test
  func animatedArtworkViewReturnsArtworkForSongQueueItems() throws {
    let song = try Song.mock
    let view = AnimatedArtworkView(queue: ApplicationMusicPlayer.shared.queue)
    let artwork = try #require(view.artwork(for: .song(song)))
    let expectedArtwork = try #require(song.artwork)

    #expect(artwork.maximumWidth == expectedArtwork.maximumWidth)
    #expect(artwork.maximumHeight == expectedArtwork.maximumHeight)
    #expect(artwork.url(width: 300, height: 300) == expectedArtwork.url(width: 300, height: 300))
  }

  @available(iOS 18.0, macOS 15.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *)
  @Test
  func animatedArtworkViewPadsShortColorSets() {
    let view = AnimatedArtworkView(queue: ApplicationMusicPlayer.shared.queue)
    let colors = view.normalizedColors([.red, .blue])

    #expect(colors.count == 16)
  }

  @available(iOS 18.0, macOS 15.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *)
  @Test
  func animatedArtworkViewUsesFallbackColorsWhenEmpty() {
    let view = AnimatedArtworkView(queue: ApplicationMusicPlayer.shared.queue)
    let colors = view.normalizedColors([])

    #expect(colors.count == 16)
  }
}
