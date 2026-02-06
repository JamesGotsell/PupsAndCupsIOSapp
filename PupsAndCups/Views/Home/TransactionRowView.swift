import SwiftUI

struct TransactionRowView: View {
    let transaction: Transaction
    var showBusinessName: Bool = true

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.description)
                    .font(.subheadline.weight(.medium))
                    .foregroundColor(.primary)
                if showBusinessName {
                    Text(transaction.businessName)
                        .font(.caption)
                        .foregroundColor(.appAccent)
                }
                Text(transaction.locationName)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(transaction.date.relativeFormatted())
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Text(transaction.type == .earn ? "+\(transaction.pointsEarned)" : "\(transaction.pointsEarned)")
                .font(.subheadline.weight(.bold))
                .foregroundColor(transaction.type == .earn ? .green : .red)
        }
        .padding(.vertical, 4)
    }
}
