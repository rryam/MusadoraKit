//
//  CommonImageProcessing.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 10/14/24.
//

import CoreGraphics

/// Errors that can occur during image processing.
enum ImageProcessingError: Error {
  /// The provided image is invalid or cannot be processed.
  case invalidImage
  /// The image resizing operation failed.
  case resizeFailed
  /// Failed to allocate memory for image processing.
  case failedToAllocateMemory
  /// Failed to create a CGContext for image processing.
  case failedToCreateCGContext
}

/// Represents the color data of a single pixel.
struct PixelData {
  /// The red component of the pixel color (0-255).
  let red: Double
  /// The green component of the pixel color (0-255).
  let green: Double
  /// The blue component of the pixel color (0-255).
  let blue: Double
}

/// Represents a cluster of pixels in color space.
struct Cluster {
  /// The center point of the cluster in color space.
  var center: PixelData
  /// The pixels belonging to this cluster.
  var points: [PixelData]
}

/// A utility struct for common image processing operations.
struct CommonImageProcessing {
  /// Extracts the most prominent colors from a CGImage.
  ///
  /// - Parameters:
  ///   - cgImage: The CGImage to extract colors from.
  ///   - numberOfColors: The number of prominent colors to extract.
  ///
  /// - Returns: An array of CGColor objects representing the prominent colors.
  ///
  /// - Throws: An `ImageProcessingError` if the image processing fails.
  static func extractColors(from cgImage: CGImage, numberOfColors: Int) throws -> [CGColor] {
    let width = cgImage.width
    let height = cgImage.height
    let bytesPerPixel = 4
    let bytesPerRow = bytesPerPixel * width
    let bitsPerComponent = 8

    guard let data = calloc(height * width, MemoryLayout<UInt32>.size) else {
      throw ImageProcessingError.failedToAllocateMemory
    }

    defer { free(data) }

    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let bitmapInfo = CGImageAlphaInfo.premultipliedLast.rawValue

    guard let context = CGContext(data: data, width: width, height: height,
                                  bitsPerComponent: bitsPerComponent,
                                  bytesPerRow: bytesPerRow,
                                  space: colorSpace,
                                  bitmapInfo: bitmapInfo) else {
      throw ImageProcessingError.failedToCreateCGContext
    }

    context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))

    let pixelBuffer = data.bindMemory(to: UInt8.self, capacity: width * height * bytesPerPixel)
    var pixelData = [PixelData]()
    for y in 0..<height {
      for x in 0..<width {
        let offset = ((width * y) + x) * bytesPerPixel
        let r = pixelBuffer[offset]
        let g = pixelBuffer[offset + 1]
        let b = pixelBuffer[offset + 2]
        pixelData.append(PixelData(red: Double(r), green: Double(g), blue: Double(b)))
      }
    }

    let clusters = kMeansCluster(pixels: pixelData, k: numberOfColors)

    return clusters.map { cluster -> CGColor in
      CGColor(red: cluster.center.red / 255.0,
              green: cluster.center.green / 255.0,
              blue: cluster.center.blue / 255.0,
              alpha: 1.0)
    }
  }

  /// Performs k-means clustering on a set of pixels.
  ///
  /// - Parameters:
  ///   - pixels: An array of PixelData to cluster.
  ///   - k: The number of clusters to create.
  ///   - maxIterations: The maximum number of iterations to perform (default is 10).
  ///
  /// - Returns: An array of Cluster objects representing the final clusters.
  private static func kMeansCluster(pixels: [PixelData], k: Int, maxIterations: Int = 10) -> [Cluster] {
    var clusters = [Cluster]()
    for _ in 0..<k {
      if let randomPixel = pixels.randomElement() {
        clusters.append(Cluster(center: randomPixel, points: []))
      }
    }

    for _ in 0..<maxIterations {
      for clusterIndex in 0..<clusters.count {
        clusters[clusterIndex].points.removeAll()
      }

      for pixel in pixels {
        var minDistance = Double.greatestFiniteMagnitude
        var closestClusterIndex = 0
        for (index, cluster) in clusters.enumerated() {
          let distance = euclideanDistance(pixel1: pixel, pixel2: cluster.center)
          if distance < minDistance {
            minDistance = distance
            closestClusterIndex = index
          }
        }
        clusters[closestClusterIndex].points.append(pixel)
      }

      for clusterIndex in 0..<clusters.count {
        let cluster = clusters[clusterIndex]
        if cluster.points.isEmpty { continue }
        let sum = cluster.points.reduce(PixelData(red: 0, green: 0, blue: 0)) { result, pixel -> PixelData in
          return PixelData(red: result.red + pixel.red, green: result.green + pixel.green, blue: result.blue + pixel.blue)
        }
        let count = Double(cluster.points.count)
        clusters[clusterIndex].center = PixelData(red: sum.red / count, green: sum.green / count, blue: sum.blue / count)
      }
    }

    return clusters
  }

  /// Calculates the Euclidean distance between two pixels in color space.
  ///
  /// - Parameters:
  ///   - pixel1: The first pixel.
  ///   - pixel2: The second pixel.
  ///
  /// - Returns: The Euclidean distance between the two pixels.
  private static func euclideanDistance(pixel1: PixelData, pixel2: PixelData) -> Double {
    let dr = pixel1.red - pixel2.red
    let dg = pixel1.green - pixel2.green
    let db = pixel1.blue - pixel2.blue
    return sqrt(dr * dr + dg * dg + db * db)
  }
}
