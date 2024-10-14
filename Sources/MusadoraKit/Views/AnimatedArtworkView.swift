import SwiftUI
import MusicKit

/// A view that displays an animated artwork with a dynamic mesh gradient background.
///
/// This view uses the current queue entry's artwork to create a visually appealing
/// animated background. It extracts dominant colors from the artwork and uses them
/// to generate a mesh gradient that animates over time.
///
/// - Important: This view is available on iOS 18, macOS 15, watchOS 11, tvOS 18, and visionOS 2 or later.
@available(iOS 18.0, macOS 15.0, watchOS 11.0, tvOS 18.0, visionOS 2.0, *)
public struct AnimatedArtworkView: View {
  /// The music player queue to observe for current entry changes.
  @ObservedObject private var queue: MusicPlayer.Queue
  
  /// The current entry in the music player queue.
  @State private var currentEntry: MusicPlayer.Queue.Entry?
  
  /// The dominant colors extracted from the artwork.
  @State private var dominantColors: [Color] = []
  
  /// The artwork to display, if provided directly.
  var artwork: MusicKit.Artwork?
  
  /// The width of the artwork image to fetch.
  private let width: Int
  
  /// The height of the artwork image to fetch.
  private let height: Int
  
  /// The points used to define the mesh gradient.
  @State private var points: [SIMD2<Float>] = [
    SIMD2<Float>(0.000, 0.000),
    SIMD2<Float>(0.333, 0.000),
    SIMD2<Float>(0.667, 0.000),
    SIMD2<Float>(1.000, 0.000),
    SIMD2<Float>(0.000, 0.333),
    SIMD2<Float>(0.789, 0.234),
    SIMD2<Float>(0.456, 0.901),
    SIMD2<Float>(1.000, 0.333),
    SIMD2<Float>(0.000, 0.667),
    SIMD2<Float>(0.321, 0.567),
    SIMD2<Float>(0.765, 0.123),
    SIMD2<Float>(1.000, 0.667),
    SIMD2<Float>(0.000, 1.000),
    SIMD2<Float>(0.333, 1.000),
    SIMD2<Float>(0.667, 1.000),
    SIMD2<Float>(1.000, 1.000)
  ]
  
  /// Initializes a new instance of `AnimatedArtworkView`.
  ///
  /// - Parameters:
  ///   - queue: The music player queue to observe.
  ///   - artwork: An optional artwork to display instead of the queue's current entry artwork.
  ///   - width: The width of the artwork image to fetch. Defaults to 300.
  ///   - height: The height of the artwork image to fetch. Defaults to 300.
  public init(queue: MusicPlayer.Queue, artwork: MusicKit.Artwork? = nil, width: Int = 300, height: Int = 300) {
    self.queue = queue
    self.artwork = artwork
    self.width = width
    self.height = height
  }
  
  public var body: some View {
    TimelineView(.animation) { timeline in
      MeshGradient(width: 4, height: 4, points: gradientContent(for: timeline.date), colors: dominantColors, smoothsColors: true)
    }
    .ignoresSafeArea()
    .task {
      await extractColors()
    }
    .onChange(of: queue.currentEntry) { _, _ in
      Task {
        if let artwork = self.artwork {
          return
        } else {
          await extractColors()
        }
      }
    }
  }
  
  /// Extracts the dominant colors from the artwork.
  private func extractColors() async {
    do {
      let colors: [Color]
      if let artwork = self.artwork {
        colors = try await artwork.fetchColors(width: width, height: height, numberOfColors: 16)
      } else if case .song(let song) = queue.currentEntry?.item,
                let songArtwork = song.artwork {
        colors = try await songArtwork.fetchColors(width: width, height: height, numberOfColors: 16)
      } else {
        colors = []
      }
      
      await MainActor.run {
        self.dominantColors = colors
      }
    } catch {
      print("Error extracting colors: \(error)")
    }
  }
  
  /// Generates the gradient content for a given date.
  ///
  /// - Parameter date: The current date used for animation.
  /// - Returns: An array of SIMD2<Float> points representing the gradient positions.
  private func gradientContent(for date: Date) -> [SIMD2<Float>] {
    let phase = CGFloat(date.timeIntervalSince1970) / 3.0
    
    var animatedPositions = points
    
    // Animate edge points
    animatedPositions[1].x = Float(0.33 + 0.1 * cos(phase * 0.7))  // Top edge
    animatedPositions[2].x = Float(0.67 - 0.1 * cos(phase * 0.8))  // Top edge
    animatedPositions[4].y = Float(0.33 + 0.1 * cos(phase * 0.9))  // Left edge
    animatedPositions[7].y = Float(0.37 - 0.1 * cos(phase * 0.6))  // Left edge
    animatedPositions[11].y = Float(0.67 - 0.1 * cos(phase * 1.2)) // Bottom edge
    animatedPositions[13].x = Float(0.33 + 0.1 * cos(phase * 1.3)) // Right edge
    animatedPositions[14].x = Float(0.67 - 0.1 * cos(phase * 1.4)) // Right edge
    
    // Animate inner points
    animatedPositions[5].x = Float(0.33 + 0.15 * cos(phase * 0.8))
    animatedPositions[5].y = Float(0.33 + 0.15 * cos(phase * 0.9))
    animatedPositions[6].x = Float(0.67 - 0.15 * cos(phase * 1.0))
    animatedPositions[6].y = Float(0.33 + 0.15 * cos(phase * 1.1))
    animatedPositions[9].x = Float(0.33 + 0.15 * cos(phase * 1.2))
    animatedPositions[9].y = Float(0.67 - 0.15 * cos(phase * 1.3))
    animatedPositions[10].x = Float(0.67 - 0.15 * cos(phase * 1.4))
    animatedPositions[10].y = Float(0.67 - 0.15 * cos(phase * 1.5))
    
    return animatedPositions
  }
}
