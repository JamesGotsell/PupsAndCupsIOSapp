import SwiftUI

struct BusinessListItemView: View {
    let business: Business
    let isJoined: Bool
    let onJoin: () -> Void
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 16) {
                // Business icon
                ZStack {
                    Circle()
                        .fill(categoryColor.opacity(0.15))
                        .frame(width: 50, height: 50)
                    Image(systemName: business.category.iconName)
                        .font(.system(size: 20))
                        .foregroundColor(categoryColor)
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(business.name)
                        .font(.headline)
                        .foregroundColor(.primary)

                    Text(business.category.displayName)
                        .font(.caption)
                        .foregroundColor(.secondary)

                    if let location = business.locations.first {
                        Text(location.address)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                    }
                }

                Spacer()

                if isJoined {
                    Text("Member")
                        .font(.caption.weight(.semibold))
                        .foregroundColor(.appAccent)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.appAccent.opacity(0.1))
                        .clipShape(Capsule())
                } else {
                    Button {
                        onJoin()
                    } label: {
                        Text("Join")
                            .font(.caption.weight(.bold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(Color.appAccent)
                            .clipShape(Capsule())
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding()
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        }
        .buttonStyle(.plain)
    }

    private var categoryColor: Color {
        switch business.category {
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
