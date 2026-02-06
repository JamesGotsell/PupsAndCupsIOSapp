import SwiftUI

struct FloatingActionButton: View {
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "qrcode.viewfinder")
                .font(.system(size: 24, weight: .semibold))
                .foregroundColor(.white)
                .frame(width: 60, height: 60)
                .background(Color.appAccent)
                .clipShape(Circle())
                .shadow(color: Color.appAccent.opacity(0.4), radius: 8, x: 0, y: 4)
        }
    }
}
