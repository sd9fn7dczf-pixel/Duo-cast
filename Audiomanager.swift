

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
                mode: .default
            )

            try session.setActive(true)

            print("DUOCAST audio ready")

        } catch {
            print("Audio error: \(error)")
        }
    }

    func loadStreamOne(url: URL) throws {
        playerOne = try AVAudioPlayer(contentsOf: url)
        playerOne?.volume = streamOneVolume
        playerOne?.prepareToPlay()
    }

    func loadStreamTwo(url: URL) throws {
        playerTwo = try AVAudioPlayer(contentsOf: url)
        playerTwo?.volume = streamTwoVolume
        playerTwo?.prepareToPlay()
    }

    func toggleStreamOne() {
        guard let player = playerOne else { return }

        if player.isPlaying {
            player.pause()
            isStreamOnePlaying = false
        } else if player.play() {
            isStreamOnePlaying = true
        }
    }

    func toggleStreamTwo() {
        guard let player = playerTwo else { return }

        if player.isPlaying {
            player.pause()
            isStreamTwoPlaying = false
        } else if player.play() {
            isStreamTwoPlaying = true
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
