//
//  Endpoint.swift
//  Endpoint
//
//  Created by Rudrank Riyam on 19/04/22.
//

import Foundation

protocol Endpoint {
  var name: String { get }
  var description: String { get }
  var previewURL: String { get }
  var url: URL { get async throws }
}
