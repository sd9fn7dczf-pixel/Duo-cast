
import Foundation
import AVFoundation
import Combine

@MainActor
final class AudioManager: ObservableObject {

    @Published var isStreamOnePlaying = false
    @Published var isStreamTwoPlaying = false

    @Published var streamOneVolume: Float = 0.7
    @Published var streamTwoVolume: Float = 0.7

    private var playerOne: AVAudioPlayer?
    private var playerTwo: AVAudioPlayer?

    func configureAudioSession() {
        do {
            let session = AVAudioSession.sharedInstance()

            try session.setCategory(
                .playback,
                mode: .default,
                options: []
            )

            try session.setActive(true)

            print("DUOCAST audio session ready")

        } catch {
            print("Audio setup error: \(error)")
        }
    }

    func stopAll() {
        playerOne?.stop()
        playerTwo?.stop()

        isStreamOnePlaying = false
        isStreamTwoPlaying = false
    }

    func setStreamOneVolume(_ value: Float) {
        streamOneVolume = value
        playerOne?.volume = value
    }

    func setStreamTwoVolume(_ value: Float) {
        streamTwoVolume = value
        playerTwo?.volume = value
    }
}
