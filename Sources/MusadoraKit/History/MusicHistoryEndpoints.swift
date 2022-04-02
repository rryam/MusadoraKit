//
//  MusicHistoryEndpoints.swift
//  MusicHistoryEndpoints
//
//  Created by Rudrank Riyam on 02/04/22.
//

import Foundation

public enum MusicHistoryEndpoints {
    case heavyRotation
    case recentlyAdded
    case recentlyPlayed

    var path: String {
        switch self {
            case .heavyRotation: return "history/heavy-rotation"
            case .recentlyAdded: return "library/recently-added"
            case .recentlyPlayed: return "recent/played"
        }
    }
}
