import Foundation

@MainActor
final class DiscoverViewModel: ObservableObject {
    @Published var businesses: [Business] = []
    @Published var joinedBusinessIds: Set<UUID> = []
    @Published var searchQuery = ""
    @Published var selectedCategory: BusinessCategory?
    @Published var isLoading = false
    @Published var isJoining = false
    @Published var error: APIError?
    @Published var newMembership: Membership?

    private let service: APIServiceProtocol

    init(service: APIServiceProtocol = MockAPIService()) {
        self.service = service
    }

    func load() async {
        isLoading = true
        error = nil
        do {
            async let businessesResult = service.searchBusinesses(query: searchQuery, category: selectedCategory)
            async let membershipsResult = service.fetchMyMemberships()

            businesses = try await businessesResult
            let memberships = try await membershipsResult
            joinedBusinessIds = Set(memberships.map { $0.businessId })
        } catch let apiError as APIError {
            error = apiError
        } catch {
            self.error = .networkError(error)
        }
        isLoading = false
    }

    func search() async {
        await load()
    }

    func joinBusiness(_ business: Business) async {
        isJoining = true
        error = nil
        do {
            let membership = try await service.joinBusiness(id: business.id)
            joinedBusinessIds.insert(business.id)
            newMembership = membership
        } catch let apiError as APIError {
            error = apiError
        } catch {
            self.error = .networkError(error)
        }
        isJoining = false
    }

    func clearNewMembership() {
        newMembership = nil
    }

    func isJoined(_ business: Business) -> Bool {
        joinedBusinessIds.contains(business.id)
    }
}
