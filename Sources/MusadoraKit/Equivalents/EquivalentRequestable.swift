//
//  EquivalentRequestable.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 18/03/23.
//

/// A protocol for music items that your app can fetch by
/// using a equivalent request.
public protocol EquivalentRequestable: MusicItem, Codable {
}

extension Album: EquivalentRequestable {
}

extension Song: EquivalentRequestable {
}

extension MusicVideo: EquivalentRequestable {
}

/// A protocol indicating that a music item can be fetched from a specific storefront using its identifier.
/// Conforming types should provide the resource path component used in the Apple Music API URL.
public protocol StorefrontRequestable: MusicItem, Decodable {
    /// The resource path component used in the Apple Music API URL.
    /// For example, for songs, this would be "songs".
    static var resourcePath: String { get }
}

extension Song: StorefrontRequestable {
    public static var resourcePath: String { "songs" }
}

extension Album: StorefrontRequestable {
    public static var resourcePath: String { "albums" }
}

extension MusicVideo: StorefrontRequestable {
    public static var resourcePath: String { "music-videos" }
}
