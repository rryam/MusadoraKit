//
//  SettingsView.swift
//  Musadora
//
//  Created by Rudrank Riyam on 17/03/23.
//

import SwiftUI

struct SettingsView: View {
  var body: some View {
    NavigationListStack("Settings") {
      Text("Made for [MusadoraKit](https://github.com/rryam/MusadoraKit). Go ⭐️ it!")

      Text("Made by [Rudrank Riyam](https://twitter.com/rudrankriyam). Go follow him!")
    }
    .tint(.indigo)
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView()
  }
}
