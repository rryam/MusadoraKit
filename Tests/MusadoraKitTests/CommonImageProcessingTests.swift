import CoreGraphics
import Foundation
@testable import MusadoraKit
import Testing

@Suite
struct CommonImageProcessingTests {
  @Test
  func extractColorsWithZeroColorsReturnsEmpty() throws {
    let image = try makeTestImage()
    let colors = try CommonImageProcessing.extractColors(from: image, numberOfColors: 0)
    #expect(colors.isEmpty)
  }

  @Test
  func extractColorsWithOneColorReturnsSingleColor() throws {
    let image = try makeTestImage(red: 255, green: 0, blue: 0)
    let colors = try CommonImageProcessing.extractColors(from: image, numberOfColors: 1)
    #expect(colors.count == 1)
  }

  private func makeTestImage(red: UInt8 = 0, green: UInt8 = 0, blue: UInt8 = 0, alpha: UInt8 = 255) throws -> CGImage {
    let width = 1
    let height = 1
    let bytesPerPixel = 4
    let data = Data([red, green, blue, alpha])

    guard let provider = CGDataProvider(data: data as CFData) else {
      throw URLError(.badURL)
    }

    let colorSpace = CGColorSpaceCreateDeviceRGB()
    let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)

    guard let image = CGImage(
      width: width,
      height: height,
      bitsPerComponent: 8,
      bitsPerPixel: 32,
      bytesPerRow: bytesPerPixel,
      space: colorSpace,
      bitmapInfo: bitmapInfo,
      provider: provider,
      decode: nil,
      shouldInterpolate: false,
      intent: .defaultIntent
    ) else {
      throw URLError(.badURL)
    }

    return image
  }
}
