//
//  MusicLibraryResourceRequest.swift
//  MusicLibraryResourceRequest
//
//  Created by Rudrank Riyam on 02/04/22.
//

import MusicKit

/// A request that your app uses to fetch items from the user's library
/// using a filter.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public struct MusicLibraryResourceRequest<MusicItemType> where MusicItemType: MusicItem, MusicItemType: Decodable {

    /// A limit for the number of items to return
    /// in the catalog resource response.
    public var limit: Int?

    /// Creates a request to fetch items using a filter that matches
    /// a specific value.
    public init<Value>(matching keyPath: KeyPath<MusicItemType.FilterLibraryType, Value>, equalTo value: Value) where MusicItemType: FilterableLibraryItem {

    }

    /// Creates a request to fetch items using a filter that matches
    /// any value from an array of possible values.
    public init<Value>(matching keyPath: KeyPath<MusicItemType.FilterLibraryType, Value>, memberOf values: [Value]) where MusicItemType: FilterableLibraryItem {

    }

    /// Fetches items from the user's library that match a specific filter.
    // public func response() async throws -> MusicLibraryResourceResponse<MusicItemType> {}
}
