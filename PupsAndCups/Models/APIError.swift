import Foundation

enum APIError: Error, LocalizedError {
    case unauthorized
    case notFound
    case serverError(statusCode: Int)
    case networkError(Error)
    case decodingError(Error)
    case insufficientPoints
    case invalidQRCode
    case unknown

    var errorDescription: String? {
        switch self {
        case .unauthorized:
            return "You are not authorized. Please log in again."
        case .notFound:
            return "The requested resource was not found."
        case .serverError(let code):
            return "Server error (code \(code)). Please try again later."
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        case .decodingError:
            return "Failed to process server response."
        case .insufficientPoints:
            return "You don't have enough points for this reward."
        case .invalidQRCode:
            return "The scanned QR code is not valid."
        case .unknown:
            return "An unknown error occurred."
        }
    }
}
