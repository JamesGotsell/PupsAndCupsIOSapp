import Foundation

@MainActor
final class HistoryViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    @Published var isLoading = false
    @Published var isLoadingMore = false
    @Published var error: APIError?
    @Published var hasMorePages = true

    private let pageSize = 20
    private var currentPage = 0
    private let service: APIServiceProtocol

    init(service: APIServiceProtocol = MockAPIService()) {
        self.service = service
    }

    func loadInitial() async {
        isLoading = true
        error = nil
        currentPage = 0
        hasMorePages = true
        do {
            let results = try await service.fetchAllTransactions(page: 0, pageSize: pageSize)
            transactions = results
            hasMorePages = results.count == pageSize
            currentPage = 1
        } catch let apiError as APIError {
            error = apiError
        } catch {
            self.error = .networkError(error)
        }
        isLoading = false
    }

    func loadMore() async {
        guard !isLoadingMore, hasMorePages else { return }
        isLoadingMore = true
        do {
            let results = try await service.fetchAllTransactions(page: currentPage, pageSize: pageSize)
            transactions.append(contentsOf: results)
            hasMorePages = results.count == pageSize
            currentPage += 1
        } catch let apiError as APIError {
            error = apiError
        } catch {
            self.error = .networkError(error)
        }
        isLoadingMore = false
    }

    func refresh() async {
        await loadInitial()
    }
}
