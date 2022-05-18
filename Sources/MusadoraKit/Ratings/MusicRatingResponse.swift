//
//  MusicRatingResponse.swift
//  MusicRatingResponse
//
//  Created by Rudrank Riyam on 18/05/22.
//

import Foundation
public struct MusicRatingResponse {

    /// A collection of items matching the filter used in
    /// the originating ``MusicCatalogRatingRequest`` and
    /// ``MusicLibraryRatingRequest``.
    public let items: [Rating]
}
