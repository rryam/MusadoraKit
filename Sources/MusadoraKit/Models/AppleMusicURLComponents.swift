//
//  AppleMusicURLComponents.swift
//  MusadoraKit
//
//  Created by Rudrank Riyam on 31/07/22.
//

import Foundation

protocol MURLComponents {
  var queryItems: [URLQueryItem]? { get set }
  var path: String { get set }
  var url: URL? { get }
}

struct AppleMusicURLComponents: MURLComponents {
  private var components: URLComponents

  init() {
    self.components = URLComponents()
    components.scheme = "https"
    components.host = "api.music.apple.com"
  }
  
  var queryItems: [URLQueryItem]? {
    get {
      components.queryItems
    } set {
      components.queryItems = newValue
    }
  }

var path: String {
    get {
      return components.path
    } set {
      components.path = "/v1/" + newValue
    }
  }

  var url: URL? {
    components.url
  }
}
