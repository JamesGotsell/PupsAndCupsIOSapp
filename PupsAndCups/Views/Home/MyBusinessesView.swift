import SwiftUI

struct MyBusinessesView: View {
    @StateObject private var viewModel: MyBusinessesViewModel
    @Binding var showScanner: Bool
    @Binding var selectedBusinessId: UUID?

    init(service: APIServiceProtocol, showScanner: Binding<Bool>, selectedBusinessId: Binding<UUID?>) {
        _viewModel = StateObject(wrappedValue: MyBusinessesViewModel(service: service))
        _showScanner = showScanner
        _selectedBusinessId = selectedBusinessId
    }

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                Group {
                    if viewModel.isLoading && viewModel.memberships.isEmpty {
                        LoadingView()
                    } else if let error = viewModel.error, viewModel.memberships.isEmpty {
                        ErrorView(message: error.localizedDescription) {
                            Task { await viewModel.load() }
                        }
                    } else if viewModel.memberships.isEmpty {
                        emptyState
                    } else {
                        scrollContent
                    }
                }

                FloatingActionButton {
                    showScanner = true
                }
                .padding(.trailing, 20)
                .padding(.bottom, 20)
            }
            .navigationTitle("Redeem")
            .task {
                await viewModel.load()
            }
        }
    }

    private var scrollContent: some View {
        ScrollView {
            VStack(spacing: 16) {
                summaryCard

                ForEach(viewModel.memberships) { membership in
                    Button {
                        selectedBusinessId = membership.businessId
                    } label: {
                        BusinessCardView(membership: membership)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding()
        }
        .background(Color.appBackground)
        .refreshable {
            await viewModel.load()
        }
    }

    private var summaryCard: some View {
        VStack(spacing: 8) {
            Text("Total Points Across All Businesses")
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.8))

            Text(viewModel.totalPoints.pointsFormatted)
                .font(.system(size: 42, weight: .bold, design: .rounded))
                .foregroundColor(.white)

            Text("\(viewModel.memberships.count) loyalty programs")
                .font(.caption)
                .foregroundColor(.white.opacity(0.7))
        }
        .padding(24)
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(
                colors: [Color.appPrimary, Color.appAccent],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: Color.appPrimary.opacity(0.3), radius: 10, x: 0, y: 5)
    }

    private var emptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: "building.2")
                .font(.system(size: 48))
                .foregroundColor(.secondary)
            Text("No Businesses Yet")
                .font(.title3.weight(.semibold))
            Text("Join a loyalty program by scanning a QR code at a participating business.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)

            Button {
                showScanner = true
            } label: {
                Label("Scan QR Code", systemImage: "qrcode.viewfinder")
            }
            .buttonStyle(.borderedProminent)
            .tint(.appAccent)
        }
    }
}
