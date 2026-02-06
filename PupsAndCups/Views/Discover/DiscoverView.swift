import SwiftUI

struct DiscoverView: View {
    @StateObject private var viewModel: DiscoverViewModel
    @Binding var selectedBusinessId: UUID?

    init(service: APIServiceProtocol, selectedBusinessId: Binding<UUID?>) {
        _viewModel = StateObject(wrappedValue: DiscoverViewModel(service: service))
        _selectedBusinessId = selectedBusinessId
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                searchBar
                categoryFilter
                contentArea
            }
            .background(Color.appBackground)
            .navigationTitle("Discover")
            .task {
                await viewModel.load()
            }
            .alert("Joined!", isPresented: Binding(
                get: { viewModel.newMembership != nil },
                set: { if !$0 { viewModel.clearNewMembership() } }
            )) {
                Button("View Business") {
                    if let membership = viewModel.newMembership {
                        selectedBusinessId = membership.businessId
                    }
                    viewModel.clearNewMembership()
                }
                Button("OK", role: .cancel) {
                    viewModel.clearNewMembership()
                }
            } message: {
                if let membership = viewModel.newMembership {
                    Text("You've joined \(membership.business.name)'s loyalty program!")
                }
            }
        }
    }

    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
            TextField("Search businesses", text: $viewModel.searchQuery)
                .textFieldStyle(.plain)
                .onSubmit {
                    Task { await viewModel.search() }
                }
            if !viewModel.searchQuery.isEmpty {
                Button {
                    viewModel.searchQuery = ""
                    Task { await viewModel.search() }
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                }
            }
        }
        .padding(12)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 1)
        .padding(.horizontal)
        .padding(.top, 8)
    }

    private var categoryFilter: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                categoryChip(nil, label: "All")
                ForEach(BusinessCategory.allCases, id: \.self) { category in
                    categoryChip(category, label: category.displayName)
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical, 12)
    }

    private func categoryChip(_ category: BusinessCategory?, label: String) -> some View {
        let isSelected = viewModel.selectedCategory == category
        return Button {
            viewModel.selectedCategory = category
            Task { await viewModel.search() }
        } label: {
            Text(label)
                .font(.subheadline.weight(isSelected ? .semibold : .regular))
                .foregroundColor(isSelected ? .white : .primary)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.appAccent : Color.white)
                .clipShape(Capsule())
                .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
        }
    }

    private var contentArea: some View {
        Group {
            if viewModel.isLoading && viewModel.businesses.isEmpty {
                LoadingView()
            } else if let error = viewModel.error, viewModel.businesses.isEmpty {
                ErrorView(message: error.localizedDescription) {
                    Task { await viewModel.load() }
                }
            } else if viewModel.businesses.isEmpty {
                emptyState
            } else {
                businessList
            }
        }
    }

    private var businessList: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(viewModel.businesses) { business in
                    BusinessListItemView(
                        business: business,
                        isJoined: viewModel.isJoined(business),
                        onJoin: {
                            Task { await viewModel.joinBusiness(business) }
                        },
                        onTap: {
                            if viewModel.isJoined(business) {
                                selectedBusinessId = business.id
                            }
                        }
                    )
                }
            }
            .padding()
        }
        .refreshable {
            await viewModel.load()
        }
    }

    private var emptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 48))
                .foregroundColor(.secondary)
            Text("No Businesses Found")
                .font(.title3.weight(.semibold))
            Text("Try a different search or browse by category.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .frame(maxHeight: .infinity)
    }
}
