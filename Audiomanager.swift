
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
            try session.setCategory(.playback, mode: .default)
            try session.setActive(true)
            print("DUOCAST audio ready")
        } catch {
            print("Audio session error: \(error)")
        }
    }

    func loadBundledTracks() {
        guard
            let urlOne = Bundle.main.url(
                forResource: "track1",
                withExtension: "wav"
            ),
            let urlTwo = Bundle.main.url(
                forResource: "track2",
                withExtension: "wav"
            )
        else {
            print("DUOCAST: Audio files not found in app bundle.")
            return
        }

        do {
            playerOne = try AVAudioPlayer(contentsOf: urlOne)
            playerTwo = try AVAudioPlayer(contentsOf: urlTwo)

            playerOne?.volume = streamOneVolume
            playerTwo?.volume = streamTwoVolume

            playerOne?.prepareToPlay()
            playerTwo?.prepareToPlay()

            print("DUOCAST: Both tracks loaded.")
        } catch {
            print("Audio loading error: \(error)")
        }
    }

    func toggleStreamOne() {
        guard let player = playerOne else {
            print("Stream 01 is not loaded.")
            return
        }

        if player.isPlaying {
            player.pause()
            isStreamOnePlaying = false
        } else {
            isStreamOnePlaying = player.play()
        }
    }

    func toggleStreamTwo() {
        guard let player = playerTwo else {
            print("Stream 02 is not loaded.")
            return
        }

        if player.isPlaying {
            player.pause()
            isStreamTwoPlaying = false
        } else {
            isStreamTwoPlaying = player.play()
        }
    }

    func setStreamOneVolume(_ value: Float) {
        streamOneVolume = value
        playerOne?.volume = value
    }

    func setStreamTwoVolume(_ value: Float) {
        streamTwoVolume = value
        playerTwo?.volume = value
    }

    func stopAll() {
        playerOne?.stop()
        playerTwo?.stop()

        isStreamOnePlaying = false
        isStreamTwoPlaying = false
    }
}


