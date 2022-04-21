//
//  MusicHistoryEndpoints.swift
//  MusicHistoryEndpoints
//
//  Created by Rudrank Riyam on 02/04/22.
//

import Foundation

/// Different endpoints related to historial data.
/// Possible types: Heavy rotation, recently added, and recently played resources.
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
