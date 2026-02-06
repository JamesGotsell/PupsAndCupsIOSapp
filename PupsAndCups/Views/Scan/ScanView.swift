import SwiftUI

struct ScanView: View {
    @StateObject private var viewModel: ScanViewModel
    @Environment(\.dismiss) private var dismiss

    init(service: APIServiceProtocol) {
        _viewModel = StateObject(wrappedValue: ScanViewModel(service: service))
    }

    var body: some View {
        ZStack {
            switch viewModel.state {
            case .idle, .scanning:
                scannerContent
            case .processing:
                LoadingView(message: "Processing scan...")
                    .background(Color.black.ignoresSafeArea())
            case .earnedPoints(let transaction):
                ScanSuccessView(transaction: transaction) {
                    dismiss()
                }
            case .joinedBusiness(let membership):
                joinSuccessView(membership: membership)
            case .error(let message):
                errorContent(message: message)
            }
        }
        .onAppear {
            viewModel.checkCameraPermission()
            viewModel.startScanning()
        }
    }

    private var scannerContent: some View {
        ZStack {
            if viewModel.cameraPermissionGranted {
                QRScannerRepresentable { code in
                    Task {
                        await viewModel.didScanCode(code)
                    }
                }
                .ignoresSafeArea()

                scannerOverlay
            } else {
                cameraPermissionDenied
            }

            VStack {
                HStack {
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 32))
                            .foregroundColor(.white)
                            .shadow(radius: 4)
                    }
                    .padding()
                }
                Spacer()
            }
        }
    }

    private var scannerOverlay: some View {
        VStack {
            Spacer()
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.white, lineWidth: 3)
                .frame(width: 250, height: 250)
            Spacer()
            Text("Point your camera at a QR code")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color.black.opacity(0.6))
                .clipShape(Capsule())
                .padding(.bottom, 60)
        }
    }

    private var cameraPermissionDenied: some View {
        VStack(spacing: 16) {
            Image(systemName: "camera.fill")
                .font(.system(size: 48))
                .foregroundColor(.secondary)
            Text("Camera Access Required")
                .font(.title3.weight(.semibold))
            Text("Please enable camera access in Settings to scan QR codes.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            Button("Open Settings") {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            }
            .buttonStyle(.borderedProminent)
            .tint(.appAccent)
        }
    }

    private func joinSuccessView(membership: Membership) -> some View {
        VStack(spacing: 24) {
            Image(systemName: "checkmark.circle.fill")
                .font(.system(size: 80))
                .foregroundColor(.green)

            Text("Welcome!")
                .font(.title.weight(.bold))
                .foregroundColor(.primary)

            Text("You've joined \(membership.business.name)")
                .font(.headline)
                .foregroundColor(.secondary)

            VStack(spacing: 8) {
                Text("Start earning points today!")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Button {
                dismiss()
            } label: {
                Text("Done")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.appAccent)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
            }
            .padding(.horizontal, 40)
            .padding(.top, 20)
        }
        .padding()
    }

    private func errorContent(message: String) -> some View {
        VStack(spacing: 16) {
            Image(systemName: "xmark.circle.fill")
                .font(.system(size: 48))
                .foregroundColor(.red)
            Text("Scan Failed")
                .font(.title3.weight(.semibold))
            Text(message)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            HStack(spacing: 16) {
                Button("Try Again") {
                    viewModel.reset()
                    viewModel.startScanning()
                }
                .buttonStyle(.borderedProminent)
                .tint(.appAccent)
                Button("Close") {
                    dismiss()
                }
                .buttonStyle(.bordered)
            }
        }
    }
}
