import SwiftUI

struct RedemptionConfirmationView: View {
    let result: RedemptionResult
    let onDismiss: () -> Void

    @State private var copied = false

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            Image(systemName: "gift.fill")
                .font(.system(size: 56))
                .foregroundColor(.appAccent)

            Text("Reward Redeemed!")
                .font(.title2.weight(.bold))
                .foregroundColor(.appPrimary)

            Text(result.reward.name)
                .font(.title3)
                .foregroundColor(.secondary)

            VStack(spacing: 8) {
                Text("Verification Code")
                    .font(.caption)
                    .foregroundColor(.secondary)

                Text(result.verificationCode)
                    .font(.system(size: 36, weight: .bold, design: .monospaced))
                    .foregroundColor(.appPrimary)
                    .padding()
                    .background(Color.appBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                Button {
                    UIPasteboard.general.string = result.verificationCode
                    copied = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        copied = false
                    }
                } label: {
                    HStack {
                        Image(systemName: copied ? "checkmark" : "doc.on.doc")
                        Text(copied ? "Copied!" : "Copy Code")
                    }
                    .font(.subheadline.weight(.medium))
                    .foregroundColor(.appAccent)
                }
            }

            Text("Show this code to the barista to claim your reward.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)

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
    }
}
