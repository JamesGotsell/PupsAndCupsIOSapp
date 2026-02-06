import SwiftUI

struct BusinessDetailView: View {
    @StateObject private var viewModel: BusinessDetailViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var selectedTab = 0

    init(service: APIServiceProtocol, businessId: UUID) {
        _viewModel = StateObject(wrappedValue: BusinessDetailViewModel(service: service, businessId: businessId))
    }

    var body: some View {
        Group {
            if viewModel.isLoading && viewModel.membership == nil {
                LoadingView()
            } else if let membership = viewModel.membership {
                contentView(membership: membership)
            } else {
                ErrorView(message: "Business not found") {
                    Task { await viewModel.loadMembership() }
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                }
            }
        }
        .task {
            await viewModel.loadMembership()
        }
        .sheet(item: Binding(
            get: { viewModel.redemptionResult.map { IdentifiableRedemption(value: $0) } },
            set: { _ in viewModel.clearRedemption() }
        )) { wrapper in
            RedemptionConfirmationView(result: wrapper.value) {
                viewModel.clearRedemption()
            }
        }
    }

    private func contentView(membership: Membership) -> some View {
        VStack(spacing: 0) {
            // Header
            businessHeader(membership: membership)

            // Tab picker
            Picker("", selection: $selectedTab) {
                Text("Info").tag(0)
                Text("Rewards").tag(1)
                Text("History").tag(2)
            }
            .pickerStyle(.segmented)
            .padding()

            // Tab content
            TabView(selection: $selectedTab) {
                BusinessInfoView(business: membership.business)
                    .tag(0)

                BusinessRewardsView(
                    viewModel: viewModel,
                    pointsBalance: membership.pointsBalance
                )
                .tag(1)

                BusinessHistoryView(viewModel: viewModel)
                    .tag(2)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
        .background(Color.appBackground)
    }

    private func businessHeader(membership: Membership) -> some View {
        VStack(spacing: 12) {
            // Business icon
            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.2))
                    .frame(width: 70, height: 70)
                Image(systemName: membership.business.category.iconName)
                    .font(.system(size: 30))
                    .foregroundColor(.white)
            }

            Text(membership.business.name)
                .font(.title2.weight(.bold))
                .foregroundColor(.white)

            HStack(spacing: 24) {
                VStack(spacing: 2) {
                    Text(membership.pointsBalance.pointsFormatted)
                        .font(.title3.weight(.bold))
                        .foregroundColor(.white)
                    Text("Available")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                }

                Divider()
                    .frame(height: 30)
                    .background(Color.white.opacity(0.3))

                VStack(spacing: 2) {
                    Text(membership.lifetimePoints.pointsFormatted)
                        .font(.title3.weight(.bold))
                        .foregroundColor(.white)
                    Text("Lifetime")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))
                }
            }
        }
        .padding(.vertical, 20)
        .frame(maxWidth: .infinity)
        .background(
            LinearGradient(
                colors: [Color.appPrimary, Color.appAccent],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
    }
}

private struct IdentifiableRedemption: Identifiable {
    let id = UUID()
    let value: RedemptionResult
}
