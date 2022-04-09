//
//  MusadoraKitError.swift
//  MusadoraKitError
//
//  Created by Rudrank Riyam on 09/04/22.
//

import Foundation
import MusicKit

public enum MusadoraKitError: Error {
    case notFound(for: String)
}

extension MusadoraKitError: CustomStringConvertible {
    public var description: String {
        switch self {
            case .notFound(let id):
                return "The specified music item could not be found for - \(id)"
        }
    }
}
