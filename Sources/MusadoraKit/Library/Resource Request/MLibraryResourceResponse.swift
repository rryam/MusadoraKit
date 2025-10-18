//
//  MLibraryResourceResponse.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 02/04/22.
//

/// An object that contains results for a library resource request.
struct MLibraryResourceResponse<MusicItemType> where MusicItemType: MusicItem {
  /// A collection of items matching the filter used in
  /// the originating ``MusicLibraryResourceRequest``.
  let items: MusicItemCollection<MusicItemType>
}

extension MLibraryResourceResponse: Equatable where MusicItemType: Equatable {}

extension MLibraryResourceResponse: Hashable where MusicItemType: Hashable {}

extension MLibraryResourceResponse: Decodable where MusicItemType: Decodable {
  // Creates a new instance by decoding from the given decoder.
  //
  // This initializer throws an error if reading from the decoder fails, or
  // if the data read is corrupted or otherwise invalid.
  //
  // - Parameter decoder: The decoder to read data from.
  //    init(from decoder: Decoder) throws {
  //
  //    }
}

extension MLibraryResourceResponse: Encodable where MusicItemType: Encodable {
  // Encodes this value into the given encoder.
  //
  // If the value fails to encode anything, `encoder` will encode an empty
  // keyed container in its place.
  //
  // This function throws an error if any values are invalid for the given
  // encoder's format.
  //
  // - Parameter encoder: The encoder to write data to.
  // func encode(to encoder: Encoder) throws { }
}

extension MLibraryResourceResponse: CustomStringConvertible, CustomDebugStringConvertible {
  var description: String {
    ""
  }

  var debugDescription: String {
    ""
  }
}
