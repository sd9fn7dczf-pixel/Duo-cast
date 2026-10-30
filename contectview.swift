
import SwiftUI

struct ContentView: View {

    @State private var carVolume = 0.7
    @State private var headphoneVolume = 0.7

    var body: some View {
        ZStack {
            Color(red: 0.04, green: 0.04, blue: 0.05)
                .ignoresSafeArea()

            VStack(spacing: 28) {

                VStack(spacing: 6) {
                    Text("DUOCAST")
                        .font(.system(size: 32, weight: .bold))
                        .tracking(4)
                        .foregroundStyle(.white)

                    Text("TWO STREAMS. ONE PHONE.")
                        .font(.system(size: 10, weight: .medium))
                        .tracking(2)
                        .foregroundStyle(.gray)
                }
                .padding(.top, 30)

                audioCard(
                    title: "STREAM 01",
                    device: "Car Bluetooth",
                    symbol: "car.fill",
                    volume: $carVolume
                )

                audioCard(
                    title: "STREAM 02",
                    device: "Headphones",
                    symbol: "headphones",
                    volume: $headphoneVolume
                )

                Spacer()

                Text("DUOCAST • VERSION 1.0")
                    .font(.caption2)
                    .foregroundStyle(.gray)
                    .padding(.bottom, 20)
            }
            .padding(.horizontal, 22)
        }
        .preferredColorScheme(.dark)
    }

    func audioCard(
        title: String,
        device: String,
        symbol: String,
        volume: Binding<Double>
    ) -> some View {

        VStack(alignment: .leading, spacing: 20) {

            HStack {
                Image(systemName: symbol)
                    .font(.title2)

                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.caption)
                        .foregroundStyle(.gray)

                    Text(device)
                        .font(.headline)
                }

                Spacer()

                Circle()
                    .fill(.gray)
                    .frame(width: 9, height: 9)
            }
            .foregroundStyle(.white)

            HStack {
                Text("VOLUME")
                    .font(.caption2)
                    .foregroundStyle(.gray)

                Spacer()

                Text("\(Int(volume.wrappedValue * 100))%")
                    .foregroundStyle(.white)
                    .font(.caption)
            }

            Slider(value: volume, in: 0...1)
                .tint(.white)
        }
        .padding(22)
        .background(Color.white.opacity(0.07))
        .clipShape(RoundedRectangle(cornerRadius: 22))
        .overlay {
            RoundedRectangle(cornerRadius: 22)
                .stroke(Color.white.opacity(0.1), lineWidth: 1)
        }
    }
}
