
import SwiftUI

struct AudioRouteView: View {

    let currentOutput: String
    let availableOutputs: [String]

    var body: some View {

        VStack(alignment: .leading, spacing: 16) {

            Text("AUDIO ROUTING")
                .font(.headline)
                .foregroundStyle(.white)

            HStack {
                Image(systemName: "waveform")
                    .foregroundStyle(.white)

                VStack(alignment: .leading) {
                    Text("CURRENT OUTPUT")
                        .font(.caption2)
                        .foregroundStyle(.gray)

                    Text(currentOutput)
                        .font(.subheadline)
                        .foregroundStyle(.white)
                }
            }

            Divider()
                .overlay(Color.gray.opacity(0.3))

            Text("AVAILABLE OUTPUTS")
                .font(.caption)
                .foregroundStyle(.gray)

            if availableOutputs.isEmpty {
                Text("No output information available")
                    .foregroundStyle(.gray)
            } else {
                ForEach(availableOutputs, id: \.self) { output in
                    HStack {
                        Image(systemName: "speaker.wave.2")
                            .foregroundStyle(.gray)

                        Text(output)
                            .font(.caption)
                            .foregroundStyle(.white)
                    }
                }
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white.opacity(0.07))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
