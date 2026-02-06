import SwiftUI

struct ScanSuccessView: View {
    let transaction: Transaction
    let onDismiss: () -> Void

    @State private var showCheckmark = false
    @State private var showDetails = false

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            ZStack {
                Circle()
                    .fill(Color.green.opacity(0.15))
                    .frame(width: 120, height: 120)

                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 72))
                    .foregroundColor(.green)
                    .scaleEffect(showCheckmark ? 1 : 0.3)
                    .opacity(showCheckmark ? 1 : 0)
            }

            if showDetails {
                VStack(spacing: 8) {
                    Text("+\(transaction.pointsEarned) Points!")
                        .font(.system(size: 36, weight: .bold, design: .rounded))
                        .foregroundColor(.appPrimary)

                    Text(transaction.description)
                        .font(.title3)
                        .foregroundColor(.secondary)

                    Text(transaction.businessName)
                        .font(.subheadline.weight(.medium))
                        .foregroundColor(.appAccent)

                    Text(transaction.locationName)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }

            Spacer()

            Button("Done") {
                onDismiss()
            }
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.appAccent)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .padding(.horizontal, 32)
            .padding(.bottom, 40)
        }
        .background(Color.appBackground.ignoresSafeArea())
        .onAppear {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                showCheckmark = true
            }
            withAnimation(.easeOut(duration: 0.4).delay(0.3)) {
                showDetails = true
            }
        }
    }
}
