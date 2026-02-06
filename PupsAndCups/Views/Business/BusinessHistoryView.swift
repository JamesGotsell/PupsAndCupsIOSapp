import SwiftUI

struct BusinessHistoryView: View {
    @ObservedObject var viewModel: BusinessDetailViewModel

    var body: some View {
        Group {
            if viewModel.isLoadingTransactions && viewModel.transactions.isEmpty {
                LoadingView()
            } else if viewModel.transactions.isEmpty {
                emptyState
            } else {
                transactionList
            }
        }
        .task {
            await viewModel.loadTransactions()
        }
    }

    private var transactionList: some View {
        List {
            ForEach(viewModel.transactions) { transaction in
                TransactionRowView(transaction: transaction, showBusinessName: false)
                    .listRowBackground(Color.clear)
                    .onAppear {
                        if transaction.id == viewModel.transactions.last?.id {
                            Task { await viewModel.loadMoreTransactions() }
                        }
                    }
            }
            if viewModel.isLoadingTransactions {
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
    }

    private var emptyState: some View {
        VStack(spacing: 16) {
            Image(systemName: "clock")
                .font(.system(size: 48))
                .foregroundColor(.secondary)
            Text("No Transaction History")
                .font(.title3.weight(.semibold))
            Text("Your activity with this business will appear here.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
    }
}
