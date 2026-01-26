//
//  MusadoraApp.swift
//  Musadora
//
//  Created by Rudrank Riyam on 09/03/23.
//

import SwiftUI

@main
struct MusadoraApp: App {
  var body: some Scene {
    WindowGroup {
      MTabView()
        .errorAlert()
    }
  }
}
