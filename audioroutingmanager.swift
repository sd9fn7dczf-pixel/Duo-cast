
import Foundation
import AVFoundation
import Combine

@MainActor
final class AudioRoutingManager: ObservableObject {

    @Published var availableOutputs: [String] = []

    @Published var currentOutput: String = "Unknown"

    private let session = AVAudioSession.sharedInstance()

    func refreshAudioRoutes() {

        availableOutputs = session.currentRoute.outputs.map {
            "\($0.portName) (\($0.portType.rawValue))"
        }

        if let output = session.currentRoute.outputs.first {
            currentOutput = output.portName
        } else {
            currentOutput = "iPhone Speaker"
        }
    }

    func printAudioCapabilities() {

        print("DUOCAST AUDIO ROUTES")

        for output in session.currentRoute.outputs {
            print("Output: \(output.portName)")
            print("Type: \(output.portType.rawValue)")
        }
    }
}
