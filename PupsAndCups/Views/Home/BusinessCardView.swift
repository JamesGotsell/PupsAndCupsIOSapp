import SwiftUI

struct BusinessCardView: View {
    let membership: Membership

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 12) {
                // Business logo/icon
                ZStack {
                    Circle()
                        .fill(categoryColor.opacity(0.15))
                        .frame(width: 50, height: 50)
                    Image(systemName: membership.business.category.iconName)
                        .font(.system(size: 22))
                        .foregroundColor(categoryColor)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(membership.business.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .lineLimit(1)

                    Text(membership.business.category.displayName)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Spacer()
            }

            Divider()

            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text(membership.pointsBalance.pointsFormatted)
                        .font(.title2.weight(.bold))
                        .foregroundColor(.appPrimary)
                    Text("points")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }

    private var categoryColor: Color {
        switch membership.business.category {
        case .coffee:
            return Color(red: 0.55, green: 0.35, blue: 0.20)
        case .restaurant:
            return Color(red: 0.85, green: 0.45, blue: 0.35)
        case .retail:
            return Color(red: 0.30, green: 0.55, blue: 0.80)
        case .fitness:
            return Color(red: 0.35, green: 0.70, blue: 0.45)
        case .beauty:
            return Color(red: 0.75, green: 0.45, blue: 0.70)
        case .other:
            return Color.gray
        }
    }
}
