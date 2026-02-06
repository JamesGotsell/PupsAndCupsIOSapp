import Foundation

struct Reward: Codable, Identifiable {
    let id: UUID
    let businessId: UUID
    let name: String
    let description: String
    let pointsCost: Int
    let imageName: String
    let category: String
    let isAvailable: Bool
}

struct RedemptionResult: Codable {
    let verificationCode: String
    let reward: Reward
    let redeemedAt: Date
}
