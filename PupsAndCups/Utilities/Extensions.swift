import SwiftUI

extension Date {
    func relativeFormatted() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .short
        return formatter.localizedString(for: self, relativeTo: Date())
    }

    func mediumFormatted() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
}

extension Color {
    static let appPrimary = Color(red: 0.25, green: 0.35, blue: 0.45)
    static let appAccent = Color(red: 0.40, green: 0.60, blue: 0.80)
    static let appBackground = Color(red: 0.96, green: 0.97, blue: 0.98)
}

extension Int {
    var pointsFormatted: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
