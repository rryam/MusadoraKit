//
//  FilterableCatalogRatingItem.swift
//  FilterableCatalogRatingItem
//
//  Created by Rudrank Riyam on 18/05/22.
//

import MusicKit

/// A declaration of the associated type that contains the set of library music item
/// properties your app uses as a filter for a catalog rating request.
public protocol FilterableCatalogRatingItem: MusicItem, Decodable {

    /// The associated type that contains the set of library music item properties
    /// your app uses as a filter for a catalog rating request.
    associatedtype FilterableCatalogRatingType
}

/// Album properties your app uses as a filter for a catalog rating request.
public protocol AlbumCatalogRatingFilter {

    /// The unique identifier for the album.
    var id: MusicItemID { get }
}

/// Song properties your app uses as a filter for a catalog rating request.
public protocol SongCatalogRatingFilter {

    /// The unique identifier for the song.
    var id: MusicItemID { get }
}

/// Station properties your app uses as a filter for a catalog rating request.
public protocol StationCatalogRatingFilter {

    /// The unique identifier for the artist.
    var id: MusicItemID { get }
}

/// Playlist properties your app uses as a filter for a catalog rating request.
public protocol PlaylistCatalogRatingFilter {

    /// The unique identifier for the playlist.
    var id: MusicItemID { get }
}

/// Music video properties your app uses as a filter for a catalog rating request.
public protocol MusicVideoCatalogRatingFilter {

    /// The unique identifier for the music video.
    var id: MusicItemID { get }
}

/// Album properties your app uses as a filter for a catalog rating request.
extension Album: FilterableCatalogRatingItem {

    /// The associated type that contains the set of album properties
    /// your app uses as a filter for a catalog rating request.
    public typealias FilterableCatalogRatingType = AlbumCatalogRatingFilter
}

extension Playlist: FilterableCatalogRatingItem {

    /// The associated type that contains the set of playlist properties
    /// your app uses as a filter for a catalog rating request.
    public typealias FilterableCatalogRatingType = PlaylistCatalogRatingFilter
}

extension Song: FilterableCatalogRatingItem {

    /// The associated type that contains the set of song properties
    /// your app uses as a filter for a catalog rating request.
    public typealias FilterableCatalogRatingType = SongCatalogRatingFilter
}

extension Station: FilterableCatalogRatingItem {

    /// The associated type that contains the set of station properties
    /// your app uses as a filter for a catalog rating request.
    public typealias FilterableCatalogRatingType = StationCatalogRatingFilter
}

extension MusicVideo: FilterableCatalogRatingItem {

    /// The associated type that contains the set of music video properties
    /// your app uses as a filter for a catalog rating request.
    public typealias FilterableCatalogRatingType = MusicVideoCatalogRatingFilter
}
