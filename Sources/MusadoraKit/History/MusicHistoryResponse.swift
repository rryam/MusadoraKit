//
//  MusicHistoryResponse.swift
//  MusicHistoryResponse
//
//  Created by Rudrank Riyam on 02/04/22.
//

import MusicKit

/// An object that contains results for a history request.
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public struct MusicHistoryResponse {

    /// A collection of historical resources based on the `MusicHistoryRequest`.
    public let items: MusicItemCollection<UserMusicItem>
}
