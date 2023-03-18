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
