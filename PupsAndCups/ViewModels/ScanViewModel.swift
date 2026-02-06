import AVFoundation
import Foundation

enum ScanState: Equatable {
    case idle
    case scanning
    case processing
    case earnedPoints(Transaction)
    case joinedBusiness(Membership)
    case error(String)

    static func == (lhs: ScanState, rhs: ScanState) -> Bool {
        switch (lhs, rhs) {
        case (.idle, .idle), (.scanning, .scanning), (.processing, .processing):
            return true
        case (.earnedPoints(let a), .earnedPoints(let b)):
            return a.id == b.id
        case (.joinedBusiness(let a), .joinedBusiness(let b)):
            return a.id == b.id
        case (.error(let a), .error(let b)):
            return a == b
        default:
            return false
        }
    }
}

@MainActor
final class ScanViewModel: ObservableObject {
    @Published var state: ScanState = .idle
    @Published var cameraPermissionGranted = false

    private let service: APIServiceProtocol

    init(service: APIServiceProtocol = MockAPIService()) {
        self.service = service
    }

    func checkCameraPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            cameraPermissionGranted = true
        case .notDetermined:
            Task {
                let granted = await AVCaptureDevice.requestAccess(for: .video)
                cameraPermissionGranted = granted
            }
        default:
            cameraPermissionGranted = false
        }
    }

    func startScanning() {
        state = .scanning
    }

    func didScanCode(_ code: String) async {
        guard state == .scanning else { return }
        state = .processing
        do {
            let result = try await service.submitQRCode(code)
            switch result {
            case .earnedPoints(let transaction):
                state = .earnedPoints(transaction)
            case .joinedBusiness(let membership):
                state = .joinedBusiness(membership)
            }
        } catch let apiError as APIError {
            state = .error(apiError.localizedDescription)
        } catch {
            state = .error(error.localizedDescription)
        }
    }

    func reset() {
        state = .idle
    }
}
