import Foundation

@MainActor
final class ProfileViewModel: ObservableObject {
    @Published var customer: Customer?
    @Published var memberships: [Membership] = []
    @Published var isLoading = false
    @Published var error: APIError?

    private let service: APIServiceProtocol

    init(service: APIServiceProtocol = MockAPIService()) {
        self.service = service
    }

    func load() async {
        isLoading = true
        error = nil
        do {
            async let customerResult = service.fetchCustomer()
            async let membershipsResult = service.fetchMyMemberships()
            customer = try await customerResult
            memberships = try await membershipsResult
        } catch let apiError as APIError {
            error = apiError
        } catch {
            self.error = .networkError(error)
        }
        isLoading = false
    }

    func logout() async {
        do {
            try await service.logout()
        } catch {}
    }

    var totalPoints: Int {
        memberships.reduce(0) { $0 + $1.pointsBalance }
    }

    var totalLifetimePoints: Int {
        memberships.reduce(0) { $0 + $1.lifetimePoints }
    }

    var businessCount: Int {
        memberships.count
    }
}
