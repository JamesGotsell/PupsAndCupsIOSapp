import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    @State private var selectedTab = 0
    @State private var showScanner = false
    @State private var selectedBusinessId: UUID?

    var body: some View {
        TabView(selection: $selectedTab) {
            MyBusinessesView(
                service: appState.service,
                showScanner: $showScanner,
                selectedBusinessId: $selectedBusinessId
            )
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            .tag(0)

            DiscoverView(
                service: appState.service,
                selectedBusinessId: $selectedBusinessId
            )
            .tabItem {
                Label("Discover", systemImage: "magnifyingglass")
            }
            .tag(1)

            HistoryView(service: appState.service)
                .tabItem {
                    Label("Activity", systemImage: "clock.fill")
                }
                .tag(2)

            ProfileView(service: appState.service)
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
                .tag(3)
        }
        .tint(.appAccent)
        .fullScreenCover(isPresented: $showScanner) {
            ScanView(service: appState.service)
        }
        .sheet(item: $selectedBusinessId) { businessId in
            NavigationStack {
                BusinessDetailView(
                    service: appState.service,
                    businessId: businessId
                )
            }
        }
    }
}

extension UUID: @retroactive Identifiable {
    public var id: UUID { self }
}
