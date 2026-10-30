
import SwiftUI

struct ContentView: View {

    @StateObject private var audioManager = AudioManager()

    var body: some View {

        ZStack {

            Color.black.ignoresSafeArea()

            VStack(spacing: 28) {

                VStack(spacing: 6) {

                    Text("DUOCAST")
                        .font(.system(size: 32, weight: .bold))
                        .tracking(4)
                        .foregroundStyle(.white)

                    Text("TWO STREAMS. ONE PHONE.")
                        .font(.caption)
                        .tracking(2)
                        .foregroundStyle(.gray)
                }
                .padding(.top, 30)

                PlayerView(
                    title: "STREAM 01",
                    device: "Car Bluetooth",
                    symbol: "car.fill",
                    volume: $audioManager.streamOneVolume,
                    isPlaying: $audioManager.isStreamOnePlaying,
                    onPlayPause: {
                        audioManager.toggleStreamOne()
                    }
                )

                PlayerView(
                    title: "STREAM 02",
                    device: "Headphones",
                    symbol: "headphones",
                    volume: $audioManager.streamTwoVolume,
                    isPlaying: $audioManager.isStreamTwoPlaying,
                    onPlayPause: {
                        audioManager.toggleStreamTwo()
                    }
                )

                Spacer()

                Text("DUOCAST • VERSION 1.0")
                    .font(.caption2)
                    .foregroundStyle(.gray)
            }
            .padding(.horizontal, 22)
        }
        .preferredColorScheme(.dark)
        .onAppear {
            audioManager.configureAudioSession()
        }
    }
}

