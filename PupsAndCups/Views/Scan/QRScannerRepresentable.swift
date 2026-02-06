import AVFoundation
import SwiftUI

struct QRScannerRepresentable: UIViewControllerRepresentable {
    let onCodeScanned: (String) -> Void

    func makeUIViewController(context: Context) -> QRScannerViewController {
        let controller = QRScannerViewController()
        controller.onCodeScanned = onCodeScanned
        return controller
    }

    func updateUIViewController(_ uiViewController: QRScannerViewController, context: Context) {}
}

final class QRScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var onCodeScanned: ((String) -> Void)?
    private var captureSession: AVCaptureSession?
    private var previewLayer: AVCaptureVideoPreviewLayer?
    private var hasScanned = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        #if targetEnvironment(simulator)
        setupSimulatorMode()
        #else
        setupCamera()
        #endif
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer?.frame = view.bounds
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        captureSession?.stopRunning()
    }

    private func setupCamera() {
        let session = AVCaptureSession()
        guard let device = AVCaptureDevice.default(for: .video),
              let input = try? AVCaptureDeviceInput(device: device) else { return }

        if session.canAddInput(input) {
            session.addInput(input)
        }

        let output = AVCaptureMetadataOutput()
        if session.canAddOutput(output) {
            session.addOutput(output)
            output.setMetadataObjectsDelegate(self, queue: .main)
            output.metadataObjectTypes = [.qr]
        }

        let layer = AVCaptureVideoPreviewLayer(session: session)
        layer.frame = view.bounds
        layer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(layer)
        previewLayer = layer

        captureSession = session
        DispatchQueue.global(qos: .userInitiated).async {
            session.startRunning()
        }
    }

    #if targetEnvironment(simulator)
    private func setupSimulatorMode() {
        let label = UILabel()
        label.text = "Tap to simulate QR scan"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])

        let tap = UITapGestureRecognizer(target: self, action: #selector(simulateScan))
        view.addGestureRecognizer(tap)
    }

    @objc private func simulateScan() {
        guard !hasScanned else { return }
        hasScanned = true
        onCodeScanned?("MOCK-QR-\(UUID().uuidString.prefix(8))")
    }
    #endif

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard !hasScanned,
              let object = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
              let code = object.stringValue else { return }
        hasScanned = true
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        onCodeScanned?(code)
    }
}
