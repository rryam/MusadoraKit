//
//  CatalogStation.swift
//  CatalogStation
//
//  Created by Rudrank Riyam on 14/08/21.
//

import Foundation
import MusicKit

public typealias Stations = MusicItemCollection<Station>

extension AppleMusicEndpoint {
    static var catalogStations: Self {
        let queryItem = URLQueryItem(name: "filter[featured]", value: "apple-music-live-radio")
        return AppleMusicEndpoint(library: .catalog, "stations", queryItems: [queryItem])
    }
    
    static var libraryStations: Self {
        let queryItem = URLQueryItem(name: "filter[identity]", value: "personal")
        return AppleMusicEndpoint(library: .catalog, "stations", queryItems: [queryItem])
    }
}

public extension RRMusicKit {
    static func catalogStations() async throws -> Stations {
        try await self.decode(endpoint: .catalogStations)
    }
    
    static func libraryStations() async throws -> Stations {
        try await self.decode(endpoint: .libraryStations)
    }
    
    static func catalogStation(id: String) async throws -> Stations {
        let musicRequest = MusicCatalogResourceRequest<Station>(matching: \.id, equalTo: MusicItemID(rawValue: id))
        let response = try await musicRequest.response()
        
        return response.items
    }
}
