
import SwiftUI

struct PlayerView: View {

    let title: String
    let device: String
    let symbol: String

    @Binding var volume: Float
    @Binding var isPlaying: Bool

    let onPlayPause: () -> Void

    var body: some View {

        VStack(alignment: .leading, spacing: 18) {

            HStack(spacing: 14) {

                Image(systemName: symbol)
                    .font(.system(size: 25))
                    .foregroundStyle(.white)

                VStack(alignment: .leading, spacing: 5) {
                    Text(title)
                        .font(.caption)
                        .foregroundStyle(.gray)

                    Text(device)
                        .font(.headline)
                        .foregroundStyle(.white)
                }

                Spacer()

                Button(action: onPlayPause) {
                    Image(systemName: isPlaying
                          ? "pause.circle.fill"
                          : "play.circle.fill")
                        .font(.system(size: 34))
                        .foregroundStyle(.white)
                }
            }

            HStack {
                Text("VOLUME")
                    .font(.caption2)
                    .foregroundStyle(.gray)

                Spacer()

                Text("\(Int(volume * 100))%")
                    .font(.caption)
                    .foregroundStyle(.white)
            }

            Slider(value: $volume, in: 0...1)
                .tint(.white)
        }
        .padding(22)
        .background(Color.white.opacity(0.07))
        .clipShape(RoundedRectangle(cornerRadius: 22))
    }
}

