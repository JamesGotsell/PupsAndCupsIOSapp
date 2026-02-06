import Foundation

@MainActor
final class MyBusinessesViewModel: ObservableObject {
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
            memberships = try await service.fetchMyMemberships()
        } catch let apiError as APIError {
            error = apiError
        } catch {
            self.error = .networkError(error)
        }
        isLoading = false
    }

    var totalPoints: Int {
        memberships.reduce(0) { $0 + $1.pointsBalance }
    }
}
