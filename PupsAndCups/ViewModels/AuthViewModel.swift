import Foundation

@MainActor
final class AuthViewModel: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var isLoading = false
    @Published var error: String?

    private let service: APIServiceProtocol

    init(service: APIServiceProtocol) {
        self.service = service
    }

    func login() async -> String? {
        guard !email.isEmpty, !password.isEmpty else {
            error = "Please fill in all fields."
            return nil
        }

        isLoading = true
        error = nil
        defer { isLoading = false }

        do {
            let token = try await service.login(email: email, password: password)
            return token
        } catch {
            self.error = error.localizedDescription
            return nil
        }
    }

    func register() async -> String? {
        guard !name.isEmpty, !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
            error = "Please fill in all fields."
            return nil
        }

        guard email.contains("@") && email.contains(".") else {
            error = "Please enter a valid email address."
            return nil
        }

        guard password == confirmPassword else {
            error = "Passwords do not match."
            return nil
        }

        guard password.count >= 6 else {
            error = "Password must be at least 6 characters."
            return nil
        }

        isLoading = true
        error = nil
        defer { isLoading = false }

        do {
            let token = try await service.register(name: name, email: email, password: password)
            return token
        } catch {
            self.error = error.localizedDescription
            return nil
        }
    }
}
