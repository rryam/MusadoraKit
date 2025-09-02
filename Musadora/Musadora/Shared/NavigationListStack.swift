//
//  NavigationListStack.swift
//  Musadora
//
//  Extracted to a shared location to be reused across views.
//

import SwiftUI

struct NavigationListStack<Content>: View where Content: View {
  var title: String
  var content: () -> Content

  init(_ title: String, @ViewBuilder content: @escaping () -> Content) {
    self.title = title
    self.content = content
  }

  var body: some View {
    NavigationStack {
      ScrollView {
        content()
      }
      .navigationTitle(title)
    }
  }
}

