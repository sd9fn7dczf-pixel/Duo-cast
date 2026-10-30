

import SwiftUI

struct ContentView: View {

    @StateObject private var audioManager = AudioManager()
    @StateObject private var routingManager = AudioRoutingManager()

    var body: some View {

        ZStack {
            Color.black.ignoresSafeArea()

            ScrollView {
                VStack(spacing: 24) {

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
                        volume: Binding(
                            get: { audioManager.streamOneVolume },
                            set: { audioManager.setStreamOneVolume($0) }
                        ),
                        isPlaying: $audioManager.isStreamOnePlaying,
                        onPlayPause: {
                            audioManager.toggleStreamOne()
                        }
                    )

                    PlayerView(
                        title: "STREAM 02",
                        device: "Headphones",
                        symbol: "headphones",
                        volume: Binding(
                            get: { audioManager.streamTwoVolume },
                            set: { audioManager.setStreamTwoVolume($0) }
                        ),
                        isPlaying: $audioManager.isStreamTwoPlaying,
                        onPlayPause: {
                            audioManager.toggleStreamTwo()
                        }
                    )

                    Button("STOP BOTH STREAMS") {
                        audioManager.stopAll()
                    }
                    .font(.caption.weight(.semibold))
                    .tracking(1)
                    .foregroundStyle(.white)

                    AudioRouteView(
                        currentOutput: routingManager.currentOutput,
                        availableOutputs: routingManager.availableOutputs
                    )

                    Button("REFRESH AUDIO ROUTE") {
                        routingManager.refreshAudioRoutes()
                        routingManager.printAudioCapabilities()
                    }
                    .font(.caption.weight(.semibold))
                    .foregroundStyle(.white)
                    .padding(.vertical, 10)

                    Text("DUOCAST • VERSION 1.0")
                        .font(.caption2)
                        .foregroundStyle(.gray)
                        .padding(.bottom, 20)
                }
                .padding(.horizontal, 22)
            }
        }
        .preferredColorScheme(.dark)
        .onAppear {
            audioManager.configureAudioSession()
            audioManager.loadBundledTracks()
            routingManager.refreshAudioRoutes()
        }
    }
}
