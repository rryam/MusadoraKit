//
//  CatalogView.swift
//  Musadora
//
//  Created by Rudrank Riyam on 17/03/23.
//

import SwiftUI
import MusadoraKit

struct CatalogView: View {
  var body: some View {
    NavigationListStack("Catalog") {
      NavigationLink("Station Genres", destination: StationGenresView())
    }
  }
}
