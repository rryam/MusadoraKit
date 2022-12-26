//
//  MusicRecentlyAddedRequest.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 30/06/22.
//

import Foundation
import MusicKit

/// A protocol for music items that your app can fetch by
/// using a recently added request.
public protocol MRecentlyAddedRequestable: MusicItem {
}

/// A request that your app uses to fetch items the user has recently added.
public struct MusicRecentlyAddedRequest<MusicItemType> where MusicItemType: MRecentlyAddedRequestable, MusicItemType: Decodable {

    /// Creates a request for items the user has recently added.
    public init() {}

    /// A limit for the number of items to return
    /// in the response that contains items the user has recently added.
    public var limit: Int?

    /// An offet for the request.
    public var offset: Int?

    /// A list of properties which the recently added request
    /// will fetch for each music item in the response.
    public var properties: [PartialMusicAsyncProperty<MusicItemType>] = []

    /// Fetches items the user has recently added.
//    public func response() async throws -> MusicRecentlyAddedResponse<MusicItemType> {
//        return MusicRecentlyAddedResponse(items: .init(arrayLiteral: []))
//    }
}

public struct MRecentlyAddedResponse<MusicItemType> where MusicItemType: MRecentlyAddedRequestable {

    /// A collection of items the user has recently added.
    public let items: MusicItemCollection<MusicItemType>
}

extension MRecentlyAddedResponse: Sendable {
}

extension MRecentlyAddedResponse: Decodable where MusicItemType: Decodable {
}

extension MRecentlyAddedResponse: Encodable where MusicItemType: Encodable {
}
