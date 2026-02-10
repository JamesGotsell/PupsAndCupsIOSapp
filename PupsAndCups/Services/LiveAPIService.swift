import Foundation

final class LiveAPIService: APIServiceProtocol {
    private let baseURL = URL(string: "https://api.pupsandcups.com/v1")!
    private let session: URLSession
    private let keychainService: KeychainService

    init(session: URLSession = .shared, keychainService: KeychainService = KeychainService()) {
        self.session = session
        self.keychainService = keychainService
    }

    // MARK: - Helpers

    private func authorizedRequest(for endpoint: String, method: String = "GET", body: Data? = nil) -> URLRequest {
        var request = URLRequest(url: baseURL.appendingPathComponent(endpoint))
        request.httpMethod = method
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let token = keychainService.getToken() {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        request.httpBody = body
        return request
    }

    private func perform<T: Decodable>(_ request: URLRequest) async throws -> T {
        let (data, response) = try await session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.unknown
        }
        switch httpResponse.statusCode {
        case 200...299:
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                return try decoder.decode(T.self, from: data)
            } catch {
                throw APIError.decodingError(error)
            }
        case 401:
            throw APIError.unauthorized
        case 404:
            throw APIError.notFound
        default:
            throw APIError.serverError(statusCode: httpResponse.statusCode)
        }
    }

    // MARK: - Auth

    func login(email: String, password: String) async throws -> String {
        let body = try JSONEncoder().encode(["email": email, "password": password])
        let request = authorizedRequest(for: "auth/login", method: "POST", body: body)
        let response: LoginResponse = try await perform(request)
        keychainService.saveToken(response.token)
        return response.token
    }

    func register(name: String, email: String, password: String) async throws -> String {
        let body = try JSONEncoder().encode(["name": name, "email": email, "password": password])
        let request = authorizedRequest(for: "auth/register", method: "POST", body: body)
        let response: LoginResponse = try await perform(request)
        keychainService.saveToken(response.token)
        return response.token
    }

    func logout() async throws {
        let request = authorizedRequest(for: "auth/logout", method: "POST")
        let _: EmptyResponse = try await perform(request)
        keychainService.deleteToken()
    }

    // MARK: - Customer

    func fetchCustomer() async throws -> Customer {
        let request = authorizedRequest(for: "customer")
        return try await perform(request)
    }

    // MARK: - Businesses

    func fetchMyMemberships() async throws -> [Membership] {
        let request = authorizedRequest(for: "memberships")
        return try await perform(request)
    }

    func searchBusinesses(query: String, category: BusinessCategory?) async throws -> [Business] {
        var endpoint = "businesses?q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        if let category = category {
            endpoint += "&category=\(category.rawValue)"
        }
        let request = authorizedRequest(for: endpoint)
        return try await perform(request)
    }

    func fetchBusiness(id: UUID) async throws -> Business {
        let request = authorizedRequest(for: "businesses/\(id.uuidString)")
        return try await perform(request)
    }

    func joinBusiness(id: UUID) async throws -> Membership {
        let request = authorizedRequest(for: "businesses/\(id.uuidString)/join", method: "POST")
        return try await perform(request)
    }

    // MARK: - Transactions

    func fetchTransactions(businessId: UUID, page: Int, pageSize: Int) async throws -> [Transaction] {
        let request = authorizedRequest(for: "businesses/\(businessId.uuidString)/transactions?page=\(page)&pageSize=\(pageSize)")
        return try await perform(request)
    }

    func fetchAllTransactions(page: Int, pageSize: Int) async throws -> [Transaction] {
        let request = authorizedRequest(for: "transactions?page=\(page)&pageSize=\(pageSize)")
        return try await perform(request)
    }

    func submitQRCode(_ code: String) async throws -> QRScanResult {
        let body = try JSONEncoder().encode(["qrCode": code])
        let request = authorizedRequest(for: "scan", method: "POST", body: body)
        let response: QRScanResponse = try await perform(request)

        switch response.type {
        case "earn":
            guard let transaction = response.transaction else {
                throw APIError.unknown
            }
            return .earnedPoints(transaction)
        case "join":
            guard let membership = response.membership else {
                throw APIError.unknown
            }
            return .joinedBusiness(membership)
        default:
            throw APIError.invalidQRCode
        }
    }

    // MARK: - Rewards

    func fetchRewards(businessId: UUID) async throws -> [Reward] {
        let request = authorizedRequest(for: "businesses/\(businessId.uuidString)/rewards")
        return try await perform(request)
    }

    func redeemReward(rewardId: UUID) async throws -> RedemptionResult {
        let request = authorizedRequest(for: "rewards/\(rewardId.uuidString)/redeem", method: "POST")
        return try await perform(request)
    }
}

// MARK: - Response Types

private struct LoginResponse: Decodable {
    let token: String
}

private struct EmptyResponse: Decodable {}

private struct QRScanResponse: Decodable {
    let type: String
    let transaction: Transaction?
    let membership: Membership?
}
