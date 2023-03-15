//
//  HistoryView.swift
//  Musadora
//
//  Created by Rudrank Riyam on 13/03/23.
//

import SwiftUI

struct HistoryView: View {
  var body: some View {
    NavigationListStack("History") {
      NavigationLink("Recently added", destination: RecentlyAddedView())
      NavigationLink("Recently played", destination: RecentlyPlayedView())
    }
  }
}
