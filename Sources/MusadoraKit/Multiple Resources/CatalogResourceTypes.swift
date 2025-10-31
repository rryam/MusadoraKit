//
//  CatalogResourceTypes.swift
//  MusadoraKit
//
//  Created by Assistant on 31/10/2025.
//

import Foundation
@_exported import MusicKit

/// A collection of music item identifiers organized by resource type.
/// Used for batch requests to fetch multiple resources of different types.
/// Equivalent to `[MusicCatalogResourcesType.Key: [MusicItemID]]`.
@available(iOS 15.4, macOS 12.3, tvOS 15.4, watchOS 9.0, visionOS 1.0, *)
public typealias CatalogResourceIdentifiers = [MusicCatalogResourcesType.Key: [MusicItemID]]
