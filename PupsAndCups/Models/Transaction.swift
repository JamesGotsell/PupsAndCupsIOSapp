import Foundation

enum TransactionType: String, Codable {
    case earn
    case redeem
}

struct Transaction: Codable, Identifiable {
    let id: UUID
    let businessId: UUID
    let businessName: String
    let date: Date
    let description: String
    let pointsEarned: Int
    let locationName: String
    let type: TransactionType
}
