import Foundation

struct Membership: Codable, Identifiable {
    let id: UUID
    let businessId: UUID
    let business: Business
    var pointsBalance: Int
    var lifetimePoints: Int
    let joinedDate: Date
}
