//
//  CatalogEndpointMacro.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 21/06/25.
//

import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct CatalogEndpointMacro: MemberMacro {
    public static func expansion(
        of node: AttributeSyntax,
        providingMembersOf declaration: some DeclGroupSyntax,
        in context: some MacroExpansionContext
    ) throws -> [DeclSyntax] {
        // Extract the resource type from the macro arguments
        guard let argument = node.arguments?.as(LabeledExprListSyntax.self)?.first,
              let memberAccess = argument.expression.as(MemberAccessExprSyntax.self),
              let resourceType = memberAccess.base?.as(DeclReferenceExprSyntax.self)?.baseName.text else {
            throw MacroError.invalidArguments
        }
        
        let resourceName = resourceType.lowercased()
        let collectionType = "\(resourceType)s"
        let propertyType = "\(resourceType)Property"
        let propertiesType = "\(resourceType)Properties"
        
        var members: [DeclSyntax] = []
        
        // Generate single item fetch methods
        members.append(generateSingleItemMethod(
            resourceType: resourceType,
            resourceName: resourceName,
            propertyType: propertyType,
            propertiesType: propertiesType,
            withProperties: true
        ))
        
        members.append(generateSingleItemVariadicMethod(
            resourceType: resourceType,
            resourceName: resourceName,
            propertyType: propertyType
        ))
        
        members.append(generateSingleItemSinglePropertyMethod(
            resourceType: resourceType,
            resourceName: resourceName,
            propertyType: propertyType
        ))
        
        members.append(generateSingleItemDefaultMethod(
            resourceType: resourceType,
            resourceName: resourceName
        ))
        
        // Generate multiple items fetch methods
        members.append(generateMultipleItemsMethod(
            resourceType: resourceType,
            resourceName: resourceName,
            collectionType: collectionType,
            propertiesType: propertiesType,
            withProperties: true
        ))
        
        members.append(generateMultipleItemsDefaultMethod(
            resourceType: resourceType,
            resourceName: resourceName,
            collectionType: collectionType
        ))
        
        // Generate UPC methods for applicable types
        if ["Album", "Song"].contains(resourceType) {
            members.append(generateUPCMethod(
                resourceType: resourceType,
                resourceName: resourceName,
                propertiesType: propertiesType,
                withProperties: true
            ))
            
            members.append(generateUPCDefaultMethod(
                resourceType: resourceType,
                resourceName: resourceName
            ))
            
            members.append(generateMultipleUPCMethod(
                resourceType: resourceType,
                resourceName: resourceName,
                collectionType: collectionType,
                propertiesType: propertiesType,
                withProperties: true
            ))
            
            members.append(generateMultipleUPCDefaultMethod(
                resourceType: resourceType,
                resourceName: resourceName,
                collectionType: collectionType
            ))
        }
        
        // Generate ISRC methods for songs
        if resourceType == "Song" {
            members.append(generateISRCMethod(
                propertiesType: propertiesType,
                withProperties: true
            ))
            
            members.append(generateISRCDefaultMethod())
            
            members.append(generateMultipleISRCMethod(
                collectionType: collectionType,
                propertiesType: propertiesType,
                withProperties: true
            ))
            
            members.append(generateMultipleISRCDefaultMethod(
                collectionType: collectionType
            ))
        }
        
        return members
    }
    
    // MARK: - Method Generators
    
    private static func generateSingleItemMethod(
        resourceType: String,
        resourceName: String,
        propertyType: String,
        propertiesType: String,
        withProperties: Bool
    ) -> DeclSyntax {
        let article = resourceType.startsWithVowel ? "an" : "a"
        return """
        /// Fetch \(raw: article) \(raw: resourceName) from the Apple Music catalog by using its identifier.
        ///
        /// - Parameters:
        ///   - id: The unique identifier for the \(raw: resourceName).
        ///   - properties: Additional relationships to fetch with the \(raw: resourceName).
        ///   Pass an empty array to avoid fetching additional properties.
        /// - Returns: `\(raw: resourceType)` matching the given identifier.
        static func \(raw: resourceName)(id: MusicItemID, fetch properties: \(raw: propertiesType)) async throws -> \(raw: resourceType) {
            var request = MusicCatalogResourceRequest<\(raw: resourceType)>(matching: \\.id, equalTo: id)
            request.properties = properties
            let response = try await request.response()
            
            guard let \(raw: resourceName) = response.items.first else {
                throw MusadoraKitError.notFound(for: id.rawValue)
            }
            return \(raw: resourceName)
        }
        """
    }
    
    private static func generateSingleItemVariadicMethod(
        resourceType: String,
        resourceName: String,
        propertyType: String
    ) -> DeclSyntax {
        let article = resourceType.startsWithVowel ? "an" : "a"
        return """
        /// Fetch \(raw: article) \(raw: resourceName) from the Apple Music catalog by using its identifier.
        ///
        /// - Parameters:
        ///   - id: The unique identifier for the \(raw: resourceName).
        ///   - properties: Additional relationships to fetch with the \(raw: resourceName).
        /// - Returns: `\(raw: resourceType)` matching the given identifier.
        static func \(raw: resourceName)(id: MusicItemID, fetch properties: \(raw: propertyType)...) async throws -> \(raw: resourceType) {
            try await \(raw: resourceName)(id: id, fetch: properties)
        }
        """
    }
    
    private static func generateSingleItemSinglePropertyMethod(
        resourceType: String,
        resourceName: String,
        propertyType: String
    ) -> DeclSyntax {
        let article = resourceType.startsWithVowel ? "an" : "a"
        return """
        /// Fetch \(raw: article) \(raw: resourceName) from the Apple Music catalog by using its identifier.
        ///
        /// - Parameters:
        ///   - id: The unique identifier for the \(raw: resourceName).
        ///   - property: Additional property or relationship to fetch with the \(raw: resourceName).
        /// - Returns: `\(raw: resourceType)` matching the given identifier.
        static func \(raw: resourceName)(id: MusicItemID, fetch property: \(raw: propertyType)) async throws -> \(raw: resourceType) {
            try await \(raw: resourceName)(id: id, fetch: [property])
        }
        """
    }
    
    private static func generateSingleItemDefaultMethod(
        resourceType: String,
        resourceName: String
    ) -> DeclSyntax {
        let article = resourceType.startsWithVowel ? "an" : "a"
        return """
        /// Fetch \(raw: article) \(raw: resourceName) from the Apple Music catalog by using its identifier with all properties.
        ///
        /// - Parameters:
        ///   - id: The unique identifier for the \(raw: resourceName).
        /// - Returns: `\(raw: resourceType)` matching the given identifier.
        static func \(raw: resourceName)(id: MusicItemID) async throws -> \(raw: resourceType) {
            try await \(raw: resourceName)(id: id, fetch: .all)
        }
        """
    }
    
    private static func generateMultipleItemsMethod(
        resourceType: String,
        resourceName: String,
        collectionType: String,
        propertiesType: String,
        withProperties: Bool
    ) -> DeclSyntax {
        """
        /// Fetch one or more \(raw: resourceName)s from the Apple Music catalog by using their identifiers.
        ///
        /// - Parameters:
        ///   - ids: The unique identifiers for the \(raw: resourceName)s.
        ///   - properties: Additional relationships to fetch with the \(raw: resourceName)s.
        ///   Pass an empty array to avoid fetching additional properties.
        /// - Returns: `\(raw: collectionType)` matching the given identifiers.
        static func \(raw: resourceName)s(ids: [MusicItemID], fetch properties: \(raw: propertiesType)) async throws -> \(raw: collectionType) {
            var request = MusicCatalogResourceRequest<\(raw: resourceType)>(matching: \\.id, memberOf: ids)
            request.properties = properties
            let response = try await request.response()
            return response.items
        }
        """
    }
    
    private static func generateMultipleItemsDefaultMethod(
        resourceType: String,
        resourceName: String,
        collectionType: String
    ) -> DeclSyntax {
        """
        /// Fetch one or more \(raw: resourceName)s from the Apple Music catalog by using their identifiers with all properties.
        ///
        /// - Parameters:
        ///   - ids: The unique identifiers for the \(raw: resourceName)s.
        /// - Returns: `\(raw: collectionType)` matching the given identifiers.
        static func \(raw: resourceName)s(ids: [MusicItemID]) async throws -> \(raw: collectionType) {
            try await \(raw: resourceName)s(ids: ids, fetch: .all)
        }
        """
    }
    
    private static func generateUPCMethod(
        resourceType: String,
        resourceName: String,
        propertiesType: String,
        withProperties: Bool
    ) -> DeclSyntax {
        let article = resourceType.startsWithVowel ? "an" : "a"
        return """
        /// Fetch \(raw: article) \(raw: resourceName) from Apple Music catalog by using its UPC value.
        ///
        /// - Parameters:
        ///   - upc: The UPC (Universal Product Code) value for the \(raw: resourceName).
        ///   - properties: Additional relationships to fetch with the \(raw: resourceName).
        ///   Pass an empty array to avoid fetching additional properties.
        /// - Returns: `\(raw: resourceType)` matching the given UPC value.
        static func \(raw: resourceName)s(upc: String, fetch properties: \(raw: propertiesType)) async throws -> \(raw: resourceType) {
            var request = MusicCatalogResourceRequest<\(raw: resourceType)>(matching: \\.upc, equalTo: upc)
            request.properties = properties
            let response = try await request.response()
            
            guard let \(raw: resourceName) = response.items.first else {
                throw MusadoraKitError.notFound(for: upc)
            }
            return \(raw: resourceName)
        }
        """
    }
    
    private static func generateUPCDefaultMethod(
        resourceType: String,
        resourceName: String
    ) -> DeclSyntax {
        let article = resourceType.startsWithVowel ? "an" : "a"
        return """
        /// Fetch \(raw: article) \(raw: resourceName) from Apple Music catalog by using its UPC value with all properties.
        ///
        /// - Parameters:
        ///   - upc: The UPC (Universal Product Code) value for the \(raw: resourceName).
        /// - Returns: `\(raw: resourceType)` matching the given UPC value.
        static func \(raw: resourceName)s(upc: String) async throws -> \(raw: resourceType) {
            try await \(raw: resourceName)s(upc: upc, fetch: .all)
        }
        """
    }
    
    private static func generateMultipleUPCMethod(
        resourceType: String,
        resourceName: String,
        collectionType: String,
        propertiesType: String,
        withProperties: Bool
    ) -> DeclSyntax {
        """
        /// Fetch multiple \(raw: resourceName)s from Apple Music catalog by using their UPC values.
        ///
        /// - Parameters:
        ///   - upcs: The UPC (Universal Product Code) values for the \(raw: resourceName)s.
        ///   - properties: Additional relationships to fetch with the \(raw: resourceName)s.
        ///   Pass an empty array to avoid fetching additional properties.
        /// - Returns: `\(raw: collectionType)` matching the given UPC values.
        static func \(raw: resourceName)s(upcs: [String], fetch properties: \(raw: propertiesType)) async throws -> \(raw: collectionType) {
            var request = MusicCatalogResourceRequest<\(raw: resourceType)>(matching: \\.upc, memberOf: upcs)
            request.properties = properties
            let response = try await request.response()
            return response.items
        }
        """
    }
    
    private static func generateMultipleUPCDefaultMethod(
        resourceType: String,
        resourceName: String,
        collectionType: String
    ) -> DeclSyntax {
        """
        /// Fetch multiple \(raw: resourceName)s from Apple Music catalog by using their UPC values with all properties.
        ///
        /// - Parameters:
        ///   - upcs: The UPC (Universal Product Code) values for the \(raw: resourceName)s.
        /// - Returns: `\(raw: collectionType)` matching the given UPC values.
        static func \(raw: resourceName)s(upcs: [String]) async throws -> \(raw: collectionType) {
            try await \(raw: resourceName)s(upcs: upcs, fetch: .all)
        }
        """
    }
    
    private static func generateISRCMethod(
        propertiesType: String,
        withProperties: Bool
    ) -> DeclSyntax {
        """
        /// Fetch a song from Apple Music catalog by using its ISRC value.
        ///
        /// - Parameters:
        ///   - isrc: The ISRC (International Standard Recording Code) value for the song.
        ///   - properties: Additional relationships to fetch with the song.
        ///   Pass an empty array to avoid fetching additional properties.
        /// - Returns: `Song` matching the given ISRC value.
        static func songs(isrc: String, fetch properties: \(raw: propertiesType)) async throws -> Song {
            var request = MusicCatalogResourceRequest<Song>(matching: \\.isrc, equalTo: isrc)
            request.properties = properties
            let response = try await request.response()
            
            guard let song = response.items.first else {
                throw MusadoraKitError.notFound(for: isrc)
            }
            return song
        }
        """
    }
    
    private static func generateISRCDefaultMethod() -> DeclSyntax {
        """
        /// Fetch a song from Apple Music catalog by using its ISRC value with all properties.
        ///
        /// - Parameters:
        ///   - isrc: The ISRC (International Standard Recording Code) value for the song.
        /// - Returns: `Song` matching the given ISRC value.
        static func songs(isrc: String) async throws -> Song {
            try await songs(isrc: isrc, fetch: .all)
        }
        """
    }
    
    private static func generateMultipleISRCMethod(
        collectionType: String,
        propertiesType: String,
        withProperties: Bool
    ) -> DeclSyntax {
        """
        /// Fetch multiple songs from Apple Music catalog by using their ISRC values.
        ///
        /// - Parameters:
        ///   - isrcs: The ISRC (International Standard Recording Code) values for the songs.
        ///   - properties: Additional relationships to fetch with the songs.
        ///   Pass an empty array to avoid fetching additional properties.
        /// - Returns: `\(raw: collectionType)` matching the given ISRC values.
        static func songs(isrcs: [String], fetch properties: \(raw: propertiesType)) async throws -> \(raw: collectionType) {
            var request = MusicCatalogResourceRequest<Song>(matching: \\.isrc, memberOf: isrcs)
            request.properties = properties
            let response = try await request.response()
            return response.items
        }
        """
    }
    
    private static func generateMultipleISRCDefaultMethod(
        collectionType: String
    ) -> DeclSyntax {
        """
        /// Fetch multiple songs from Apple Music catalog by using their ISRC values with all properties.
        ///
        /// - Parameters:
        ///   - isrcs: The ISRC (International Standard Recording Code) values for the songs.
        /// - Returns: `\(raw: collectionType)` matching the given ISRC values.
        static func songs(isrcs: [String]) async throws -> \(raw: collectionType) {
            try await songs(isrcs: isrcs, fetch: .all)
        }
        """
    }
}

// MARK: - Helpers

private extension String {
    var startsWithVowel: Bool {
        guard let firstChar = self.lowercased().first else { return false }
        return ["a", "e", "i", "o", "u"].contains(firstChar)
    }
}

enum MacroError: Error, CustomStringConvertible {
    case invalidArguments
    
    var description: String {
        switch self {
        case .invalidArguments:
            return "CatalogEndpoint macro requires a resource type argument (e.g., @CatalogEndpoint(resource: Album.self))"
        }
    }
}