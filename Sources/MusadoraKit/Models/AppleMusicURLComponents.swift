//
//  AppleMusicURLComponents.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 31/07/22.
//

import Foundation

public struct AppleMusicURLComponents {
  private var components: URLComponents

  public init() {
    self.components = URLComponents()
    components.scheme = "https"
    components.host = "api.music.apple.com"
  }
  
  public var queryItems: [URLQueryItem]? {
    get {
      components.queryItems
    } set {
      components.queryItems = newValue
    }
  }

 public var path: String {
    get {
      return components.path
    } set {
      components.path = "/v1/" + newValue
    }
  }

  public var url: URL? {
    components.url
  }
}
