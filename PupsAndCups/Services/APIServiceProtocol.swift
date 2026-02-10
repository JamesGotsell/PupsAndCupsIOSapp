import Foundation

enum QRScanResult {
    case earnedPoints(Transaction)
    case joinedBusiness(Membership)
}

protocol APIServiceProtocol {
    // Auth
    func login(email: String, password: String) async throws -> String
    func register(name: String, email: String, password: String) async throws -> String
    func logout() async throws

    // Customer
    func fetchCustomer() async throws -> Customer

    // Businesses
    func fetchMyMemberships() async throws -> [Membership]
    func searchBusinesses(query: String, category: BusinessCategory?) async throws -> [Business]
    func fetchBusiness(id: UUID) async throws -> Business
    func joinBusiness(id: UUID) async throws -> Membership

    // Transactions (per business)
    func fetchTransactions(businessId: UUID, page: Int, pageSize: Int) async throws -> [Transaction]
    func fetchAllTransactions(page: Int, pageSize: Int) async throws -> [Transaction]
    func submitQRCode(_ code: String) async throws -> QRScanResult

    // Rewards (per business)
    func fetchRewards(businessId: UUID) async throws -> [Reward]
    func redeemReward(rewardId: UUID) async throws -> RedemptionResult
}
