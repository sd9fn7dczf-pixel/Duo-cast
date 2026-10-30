
import Foundation
import AVFoundation
import Combine

@MainActor
final class AudioRoutingManager: ObservableObject {

    @Published var availableOutputs: [String] = []
    @Published var currentOutput: String = "Unknown"
    @Published var bluetoothDevices: [String] = []

    private let session = AVAudioSession.sharedInstance()

    func refreshAudioRoutes() {

        let outputs = session.currentRoute.outputs

        availableOutputs = outputs.map {
            "\($0.portName) (\($0.portType.rawValue))"
        }

        bluetoothDevices = outputs
            .filter {
                $0.portType == .bluetoothA2DP ||
                $0.portType == .bluetoothHFP ||
                $0.portType == .bluetoothLE
            }
            .map { $0.portName }

        currentOutput = outputs.first?.portName ?? "iPhone Speaker"
    }

    func printAudioCapabilities() {

        print("===== DUOCAST AUDIO ROUTES =====")

        for output in session.currentRoute.outputs {
            print("Device: \(output.portName)")
            print("Type: \(output.portType.rawValue)")
        }

        print("Bluetooth devices: \(bluetoothDevices)")
        print("================================")
    }
}

