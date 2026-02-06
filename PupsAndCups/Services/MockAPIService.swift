import Foundation

final class MockAPIService: APIServiceProtocol {
    private let delay: UInt64 = 500_000_000 // 0.5 seconds

    // Track joined businesses (simulates server state)
    private var joinedBusinessIds: Set<UUID> = [
        MockData.pupsAndCupsId,
        MockData.sweetTreatsId,
        MockData.pageAndBindId
    ]

    func login(email: String, password: String) async throws -> String {
        try await Task.sleep(nanoseconds: delay)
        return "mock-auth-token-\(UUID().uuidString)"
    }

    func fetchCustomer() async throws -> Customer {
        try await Task.sleep(nanoseconds: delay)
        return MockData.customer
    }

    func fetchMyMemberships() async throws -> [Membership] {
        try await Task.sleep(nanoseconds: delay)
        return MockData.memberships.filter { joinedBusinessIds.contains($0.businessId) }
    }

    func searchBusinesses(query: String, category: BusinessCategory?) async throws -> [Business] {
        try await Task.sleep(nanoseconds: delay)
        var results = MockData.businesses

        if let category = category {
            results = results.filter { $0.category == category }
        }

        if !query.isEmpty {
            let lowercasedQuery = query.lowercased()
            results = results.filter {
                $0.name.lowercased().contains(lowercasedQuery) ||
                $0.description.lowercased().contains(lowercasedQuery)
            }
        }

        return results
    }

    func fetchBusiness(id: UUID) async throws -> Business {
        try await Task.sleep(nanoseconds: delay)
        guard let business = MockData.businesses.first(where: { $0.id == id }) else {
            throw APIError.notFound
        }
        return business
    }

    func joinBusiness(id: UUID) async throws -> Membership {
        try await Task.sleep(nanoseconds: delay)
        guard let business = MockData.businesses.first(where: { $0.id == id }) else {
            throw APIError.notFound
        }

        // Check if already a member
        if joinedBusinessIds.contains(id) {
            if let existingMembership = MockData.memberships.first(where: { $0.businessId == id }) {
                return existingMembership
            }
        }

        joinedBusinessIds.insert(id)

        return Membership(
            id: UUID(),
            businessId: id,
            business: business,
            pointsBalance: 0,
            lifetimePoints: 0,
            joinedDate: Date()
        )
    }

    func fetchTransactions(businessId: UUID, page: Int, pageSize: Int) async throws -> [Transaction] {
        try await Task.sleep(nanoseconds: delay)
        let filtered = MockData.transactions.filter { $0.businessId == businessId }
        let start = page * pageSize
        guard start < filtered.count else { return [] }
        let end = min(start + pageSize, filtered.count)
        return Array(filtered[start..<end])
    }

    func fetchAllTransactions(page: Int, pageSize: Int) async throws -> [Transaction] {
        try await Task.sleep(nanoseconds: delay)
        let sorted = MockData.transactions.sorted { $0.date > $1.date }
        let start = page * pageSize
        guard start < sorted.count else { return [] }
        let end = min(start + pageSize, sorted.count)
        return Array(sorted[start..<end])
    }

    func submitQRCode(_ code: String) async throws -> QRScanResult {
        try await Task.sleep(nanoseconds: delay)
        guard !code.isEmpty else { throw APIError.invalidQRCode }

        // Parse QR code format
        // Format: "earn:{businessId}:{code}" or "join:{businessId}"
        let parts = code.split(separator: ":")

        if parts.count >= 2 {
            let action = String(parts[0])
            guard let businessId = UUID(uuidString: String(parts[1])) else {
                throw APIError.invalidQRCode
            }

            guard let business = MockData.businesses.first(where: { $0.id == businessId }) else {
                throw APIError.notFound
            }

            if action == "join" {
                let membership = try await joinBusiness(id: businessId)
                return .joinedBusiness(membership)
            } else if action == "earn" {
                let transaction = Transaction(
                    id: UUID(),
                    businessId: businessId,
                    businessName: business.name,
                    date: Date(),
                    description: "QR Scan Purchase",
                    pointsEarned: Int.random(in: 25...100),
                    locationName: business.locations.first?.name ?? "Main",
                    type: .earn
                )
                return .earnedPoints(transaction)
            }
        }

        // Legacy format - assume Pups & Cups
        let transaction = Transaction(
            id: UUID(),
            businessId: MockData.pupsAndCupsId,
            businessName: "Pups & Cups",
            date: Date(),
            description: "QR Scan Purchase",
            pointsEarned: Int.random(in: 25...100),
            locationName: "Downtown",
            type: .earn
        )
        return .earnedPoints(transaction)
    }

    func fetchRewards(businessId: UUID) async throws -> [Reward] {
        try await Task.sleep(nanoseconds: delay)
        return MockData.rewards(for: businessId)
    }

    func redeemReward(rewardId: UUID) async throws -> RedemptionResult {
        try await Task.sleep(nanoseconds: delay)

        // Search through all business rewards
        let allRewards = MockData.pupsAndCupsRewards + MockData.sweetTreatsRewards +
                        MockData.pageAndBindRewards + MockData.fitZoneRewards

        guard let reward = allRewards.first(where: { $0.id == rewardId }) else {
            throw APIError.notFound
        }

        let code = String((0..<6).map { _ in "ABCDEFGHJKLMNPQRSTUVWXYZ23456789".randomElement()! })
        return RedemptionResult(
            verificationCode: code,
            reward: reward,
            redeemedAt: Date()
        )
    }

    func logout() async throws {
        try await Task.sleep(nanoseconds: delay)
    }
}
