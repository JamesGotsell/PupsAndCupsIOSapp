import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel: ProfileViewModel
    @EnvironmentObject var appState: AppState

    init(service: APIServiceProtocol) {
        _viewModel = StateObject(wrappedValue: ProfileViewModel(service: service))
    }

    var body: some View {
        NavigationStack {
            Group {
                if let customer = viewModel.customer {
                    profileContent(customer: customer)
                } else if let error = viewModel.error {
                    ErrorView(message: error.localizedDescription) {
                        Task { await viewModel.load() }
                    }
                } else {
                    LoadingView()
                }
            }
            .navigationTitle("Profile")
            .task {
                await viewModel.load()
            }
        }
    }

    private func profileContent(customer: Customer) -> some View {
        ScrollView {
            VStack(spacing: 24) {
                profileHeader(customer: customer)
                statsSection
                accountInfoSection(customer: customer)
                logoutSection
            }
            .padding()
        }
        .background(Color.appBackground)
    }

    private func profileHeader(customer: Customer) -> some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(Color.appAccent.opacity(0.2))
                    .frame(width: 80, height: 80)
                Text(String(customer.name.prefix(1)))
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.appAccent)
            }

            Text(customer.name)
                .font(.title2.weight(.bold))
                .foregroundColor(.appPrimary)
        }
    }

    private var statsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Your Stats")
                .font(.headline)
                .foregroundColor(.appPrimary)

            HStack {
                statItem(value: viewModel.totalPoints.pointsFormatted, label: "Total Points")
                Divider().frame(height: 40)
                statItem(value: viewModel.totalLifetimePoints.pointsFormatted, label: "Lifetime")
                Divider().frame(height: 40)
                statItem(value: "\(viewModel.businessCount)", label: "Programs")
            }
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }

    private func statItem(value: String, label: String) -> some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.title3.weight(.bold))
                .foregroundColor(.appPrimary)
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
    }

    private func accountInfoSection(customer: Customer) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Account Info")
                .font(.headline)
                .foregroundColor(.appPrimary)

            infoRow(icon: "envelope.fill", label: "Email", value: customer.email)
            infoRow(icon: "calendar", label: "Member Since", value: customer.memberSince.mediumFormatted())
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }

    private func infoRow(icon: String, label: String, value: String) -> some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(.appAccent)
                .frame(width: 24)
            VStack(alignment: .leading, spacing: 2) {
                Text(label)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(value)
                    .font(.subheadline)
                    .foregroundColor(.primary)
            }
        }
    }

    private var logoutSection: some View {
        Button(role: .destructive) {
            Task {
                await viewModel.logout()
                appState.isLoggedIn = false
            }
        } label: {
            HStack {
                Image(systemName: "rectangle.portrait.and.arrow.right")
                Text("Log Out")
            }
            .font(.headline)
            .foregroundColor(.red)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        }
    }
}
