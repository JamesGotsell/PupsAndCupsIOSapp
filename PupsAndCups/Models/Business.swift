import Foundation

enum BusinessCategory: String, Codable, CaseIterable {
    case coffee
    case restaurant
    case retail
    case fitness
    case beauty
    case other

    var displayName: String {
        switch self {
        case .coffee: return "Coffee"
        case .restaurant: return "Restaurant"
        case .retail: return "Retail"
        case .fitness: return "Fitness"
        case .beauty: return "Beauty"
        case .other: return "Other"
        }
    }

    var iconName: String {
        switch self {
        case .coffee: return "cup.and.saucer.fill"
        case .restaurant: return "fork.knife"
        case .retail: return "bag.fill"
        case .fitness: return "figure.run"
        case .beauty: return "sparkles"
        case .other: return "building.2.fill"
        }
    }
}

struct Location: Codable, Identifiable {
    let id: UUID
    let name: String
    let address: String
    let hours: String?
    let latitude: Double?
    let longitude: Double?
}

struct Business: Codable, Identifiable {
    let id: UUID
    let name: String
    let description: String
    let category: BusinessCategory
    let logoURL: String?
    let locations: [Location]
    let contactEmail: String?
    let website: String?
}
