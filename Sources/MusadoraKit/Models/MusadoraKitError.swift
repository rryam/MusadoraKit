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
    case typeMissing
}

extension MusadoraKitError: CustomStringConvertible {
    public var description: String {
        switch self {
            case .notFound(let id):
                return "The specified music item could not be found for \(id)."
            case .typeMissing:
                return "One or more types must be specified for fetching top results in search suggestions."
        }
    }
}

extension MusadoraKitError: LocalizedError {
    public var errorDescription: String? {
        switch self {
            case .notFound(let id):
                return NSLocalizedString("The specified music item could not be found for \(id).",
                                         comment: "Resource Not Found")
            case .typeMissing:
                return NSLocalizedString("One or more types must be specified for fetching top results in search suggestions.",
                                         comment: "Missing Parameter")
        }
    }
}
