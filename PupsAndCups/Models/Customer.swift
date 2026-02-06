import Foundation

struct Customer: Codable, Identifiable {
    let id: UUID
    var name: String
    var email: String
    var memberSince: Date
}
