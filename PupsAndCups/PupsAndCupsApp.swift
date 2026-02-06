import SwiftUI

@MainActor
final class AppState: ObservableObject {
    @Published var isLoggedIn: Bool = true
    @Published var service: APIServiceProtocol

    init(service: APIServiceProtocol = MockAPIService()) {
        self.service = service
    }
}

@main
struct PupsAndCupsApp: App {
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
    }
}
