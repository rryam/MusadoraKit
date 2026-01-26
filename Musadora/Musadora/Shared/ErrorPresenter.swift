import SwiftUI

@MainActor
final class ErrorPresenter: ObservableObject {
  static let shared = ErrorPresenter()

  @Published var message: String?
  @Published var title: String = "Error"

  private init() {}

  nonisolated func present(_ error: Error, title: String = "Error") {
    present(message: error.localizedDescription, title: title)
  }

  nonisolated func present(message: String, title: String = "Error") {
    Task { @MainActor in
      self.title = title
      self.message = message
    }
  }

  func clear() {
    message = nil
  }
}

private struct ErrorAlertModifier: ViewModifier {
  @StateObject private var presenter = ErrorPresenter.shared

  func body(content: Content) -> some View {
    content.alert(presenter.title, isPresented: isPresentedBinding) {
      Button("OK", role: .cancel) {}
    } message: {
      Text(presenter.message ?? "")
    }
  }

  private var isPresentedBinding: Binding<Bool> {
    Binding(
      get: { presenter.message != nil },
      set: { isPresented in
        if !isPresented {
          presenter.clear()
        }
      }
    )
  }
}

extension View {
  func errorAlert() -> some View {
    modifier(ErrorAlertModifier())
  }
}
