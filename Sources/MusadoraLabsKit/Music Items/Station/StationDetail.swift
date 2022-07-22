//
//  StationDetail.swift
//  StationDetail
//
//  Created by Rudrank Riyam on 23/07/22.
//

import MusicKit

@available(iOS 16.0, tvOS 16.0, watchOS 9.0, *)
extension Station {
    public func detail(for type: StationPropertyType) -> String? {
        switch type {
            case .id:
                return id.rawValue
            case .name:
                return name
            case .url:
                return url?.absoluteString
            case .artwork:
                return nil
            case .contentRating:
                return contentRating.debugDescription
            case .duration:
                return duration?.formatted(.number).description
            case .editorialNotes:
                return editorialNotes?.description
            case .playParameters:
                return playParameters.debugDescription
            case .stationProviderName:
                return stationProviderName
            case .episodeNumber:
                return episodeNumber?.description
            case .isLive:
                return isLive.description
        }
    }
}
