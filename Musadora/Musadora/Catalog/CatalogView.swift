//
//  CatalogView.swift
//  Musadora
//
//  Created by Rudrank Riyam on 12/03/23.
//

import SwiftUI

struct CatalogView: View {
  var body: some View {
    NavigationListStack("Catalog") {
      NavigationLink("Station Genres", destination: StationGenresView())
    }
  }
}
