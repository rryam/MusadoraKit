//
//  AppleMusicURLComponents.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 31/07/22.
//

import Foundation

/// A protocol for URL components that can be used to construct URLs for API requests.
public protocol MusicURLComponents {
  /// The query items to include in the URL.
  var queryItems: [URLQueryItem]? { get set }

  /// The path for the URL, excluding the base path.
  var path: String { get set }

  /// The constructed URL, if valid.
  var url: URL? { get }
}

/// A structure that implements the `MusicURLComponents` protocol, specifically for Apple Music API requests.
public struct AppleMusicURLComponents: MusicURLComponents {
  /// The underlying `URLComponents` instance.
  private var components: URLComponents

  /// Initializes a new `AppleMusicURLComponents` instance with default values for the scheme and host.
  public init() {
    self.components = URLComponents()
    components.scheme = "https"
    components.host = "api.music.apple.com"
  }

  /// The query items to include in the URL.
  public var queryItems: [URLQueryItem]? {
    get {
      components.queryItems
    } set {
      components.queryItems = newValue
    }
  }

  /// The path for the URL, excluding the base path.
  public var path: String {
    get {
      return components.path
    } set {
      components.path = "/v1/" + newValue
    }
  }

  /// The constructed URL, if valid.
  public var url: URL? {
    components.url
  }
}
