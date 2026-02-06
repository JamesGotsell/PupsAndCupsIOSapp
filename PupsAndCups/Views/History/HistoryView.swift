import SwiftUI

struct HistoryView: View {
    @StateObject private var viewModel: HistoryViewModel

    init(service: APIServiceProtocol) {
        _viewModel = StateObject(wrappedValue: HistoryViewModel(service: service))
    }

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading && viewModel.transactions.isEmpty {
                    LoadingView()
                } else if let error = viewModel.error, viewModel.transactions.isEmpty {
                    ErrorView(message: error.localizedDescription) {
                        Task { await viewModel.loadInitial() }
                    }
                } else if viewModel.transactions.isEmpty {
                    emptyState
                } else {
                    transactionList
                }
            }
            .navigationTitle("Activity")
            .task {
                await viewModel.loadInitial()
            }
        }
    }

    private var transactionList: some View {
        List {
            ForEach(viewModel.transactions) { transaction in
                TransactionRowView(transaction: transaction, showBusinessName: true)
                    .listRowBackground(Color.clear)
                    .onAppear {
                        if transaction.id == viewModel.transactions.last?.id {
                            Task { await viewModel.loadMore() }
                        }
                    }
            }
            if viewModel.isLoadingMore {
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
                .listRowBackground(Color.clear)
            }
        }
        .listStyle(.plain)
        .background(Color.appBackground)
        .refreshable {
            await viewModel.refresh()
        }
    }

    private var emptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: "clock")
                .font(.system(size: 48))
                .foregroundColor(.secondary)
            Text("No Activity Yet")
                .font(.title3.weight(.semibold))
            Text("Your transaction history across all businesses will appear here.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
    }
}
