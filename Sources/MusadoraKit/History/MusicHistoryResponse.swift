//
//  MusicHistoryResponse.swift
//  MusicHistoryResponse
//
//  Created by Rudrank Riyam on 02/04/22.
//

import MusicKit

/// An object that contains results for a history request.
public struct MusicHistoryResponse {

    /// A collection of historical resources based on the `MusicHistoryRequest`.
    public let items: MusicItemCollection<UserMusicItem>
}

extension MusicHistoryResponse: Equatable, Hashable, Codable {}

extension MusicHistoryResponse: CustomStringConvertible {
    public var description: String {
        "MusicHistoryResponse(\(items.description)"
    }
}
