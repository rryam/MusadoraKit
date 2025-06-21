//
//  CatalogEndpoint.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 21/06/25.
//

/// A macro that generates catalog endpoint methods for a given music item type.
///
/// This macro automatically generates all the common catalog fetch methods for a music item type,
/// dramatically reducing boilerplate code. It generates methods for fetching items by ID, by multiple IDs,
/// and for applicable types, by UPC or ISRC codes.
///
/// The macro generates the following method variations:
/// - Single item fetch with properties array
/// - Single item fetch with variadic properties
/// - Single item fetch with single property
/// - Single item fetch with all properties (default)
/// - Multiple items fetch with properties
/// - Multiple items fetch with all properties (default)
/// - UPC-based fetch methods (for Album type only)
/// - ISRC-based fetch methods (for Song type only)
///
/// Example usage:
/// ```swift
/// @CatalogEndpoint(resource: Album.self)
/// extension MCatalog {}
///
/// // This generates all the album fetch methods automatically:
/// // - album(id:fetch:)
/// // - album(id:fetch:) with variadic
/// // - album(id:)
/// // - albums(ids:fetch:)
/// // - albums(ids:)
/// // - albums(upc:fetch:)
/// // - albums(upc:)
/// // - albums(upcs:fetch:)
/// // - albums(upcs:)
/// ```
///
/// For Song type, it also generates ISRC methods:
/// ```swift
/// @CatalogEndpoint(resource: Song.self)
/// extension MCatalog {}
///
/// // Generates all song methods plus:
/// // - songs(isrc:fetch:)
/// // - songs(isrc:)
/// // - songs(isrcs:fetch:)
/// // - songs(isrcs:)
/// ```
///
/// - Parameter resource: The music item type to generate endpoints for (e.g., Album.self, Song.self)
@attached(member, names: arbitrary)
public macro CatalogEndpoint<T>(resource: T.Type) = #externalMacro(
    module: "MusadoraKitMacros",
    type: "CatalogEndpointMacro"
)