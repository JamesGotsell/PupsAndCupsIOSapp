import SwiftUI

struct RewardCardView: View {
    let reward: Reward
    var canRedeem: Bool = true
    let onRedeem: () -> Void

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: reward.imageName)
                .font(.system(size: 36))
                .foregroundColor(.appAccent)
                .frame(height: 50)

            Text(reward.name)
                .font(.subheadline.weight(.semibold))
                .foregroundColor(.appPrimary)
                .multilineTextAlignment(.center)
                .lineLimit(2)

            Text(reward.description)
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .lineLimit(2)

            Spacer()

            Button {
                onRedeem()
            } label: {
                Text("\(reward.pointsCost.pointsFormatted) pts")
                    .font(.caption.weight(.bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(isEnabled ? Color.appAccent : Color.gray)
                    .clipShape(Capsule())
            }
            .disabled(!isEnabled)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .shadow(color: Color.black.opacity(0.06), radius: 5, x: 0, y: 2)
    }

    private var isEnabled: Bool {
        reward.isAvailable && canRedeem
    }
}
