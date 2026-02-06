import Foundation

@MainActor
final class BusinessDetailViewModel: ObservableObject {
    @Published var membership: Membership?
    @Published var rewards: [Reward] = []
    @Published var transactions: [Transaction] = []
    @Published var isLoading = false
    @Published var isLoadingRewards = false
    @Published var isLoadingTransactions = false
    @Published var error: APIError?
    @Published var redemptionResult: RedemptionResult?
    @Published var isRedeeming = false
    @Published var hasMoreTransactions = true

    private let service: APIServiceProtocol
    private let businessId: UUID
    private var currentPage = 0
    private let pageSize = 20

    init(service: APIServiceProtocol, businessId: UUID) {
        self.service = service
        self.businessId = businessId
    }

    func loadMembership() async {
        isLoading = true
        error = nil
        do {
            let memberships = try await service.fetchMyMemberships()
            membership = memberships.first { $0.businessId == businessId }
        } catch let apiError as APIError {
            error = apiError
        } catch {
            self.error = .networkError(error)
        }
        isLoading = false
    }

    func loadRewards() async {
        isLoadingRewards = true
        do {
            rewards = try await service.fetchRewards(businessId: businessId)
        } catch let apiError as APIError {
            error = apiError
        } catch {
            self.error = .networkError(error)
        }
        isLoadingRewards = false
    }

    func loadTransactions() async {
        isLoadingTransactions = true
        currentPage = 0
        hasMoreTransactions = true
        do {
            let results = try await service.fetchTransactions(businessId: businessId, page: 0, pageSize: pageSize)
            transactions = results
            hasMoreTransactions = results.count == pageSize
            currentPage = 1
        } catch let apiError as APIError {
            error = apiError
        } catch {
            self.error = .networkError(error)
        }
        isLoadingTransactions = false
    }

    func loadMoreTransactions() async {
        guard !isLoadingTransactions, hasMoreTransactions else { return }
        isLoadingTransactions = true
        do {
            let results = try await service.fetchTransactions(businessId: businessId, page: currentPage, pageSize: pageSize)
            transactions.append(contentsOf: results)
            hasMoreTransactions = results.count == pageSize
            currentPage += 1
        } catch let apiError as APIError {
            error = apiError
        } catch {
            self.error = .networkError(error)
        }
        isLoadingTransactions = false
    }

    func redeemReward(_ reward: Reward) async {
        isRedeeming = true
        error = nil
        do {
            redemptionResult = try await service.redeemReward(rewardId: reward.id)
        } catch let apiError as APIError {
            error = apiError
        } catch {
            self.error = .networkError(error)
        }
        isRedeeming = false
    }

    func clearRedemption() {
        redemptionResult = nil
    }
}
