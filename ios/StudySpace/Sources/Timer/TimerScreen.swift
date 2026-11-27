import SwiftUI

struct TimerScreen: View {
    @StateObject private var store = TimerStore()
    @State private var hours = "0"
    @State private var minutes = "25"
    @State private var seconds = "0"

    var body: some View {
        VStack(spacing: 32) {
            Text(store.formattedRemaining)
                .font(.system(size: 56, weight: .bold, design: .monospaced))
                .monospacedDigit()

            HStack(spacing: 12) {
                presetButton("25 min", 25)
                presetButton("5 min", 5)
                presetButton("15 min", 15)
            }

            HStack(spacing: 8) {
                durationField("HH", text: $hours)
                Text(":")
                durationField("MM", text: $minutes)
                Text(":")
                durationField("SS", text: $seconds)
            }

            HStack(spacing: 16) {
                Button(store.isRunning ? "Stop" : "Start") {
                    if store.isRunning {
                        store.stop()
                    } else {
                        let total = (Int(hours) ?? 0) * 3600 + (Int(minutes) ?? 0) * 60 + (Int(seconds) ?? 0)
                        store.start(durationSeconds: total)
                    }
                }
                .buttonStyle(.borderedProminent)

                Button("Reset") {
                    store.reset()
                    hours = "0"; minutes = "25"; seconds = "0"
                }
                .buttonStyle(.bordered)
            }
        }
        .padding()
        .navigationTitle("Timer")
    }

    private func presetButton(_ label: String, _ presetMinutes: Int) -> some View {
        Button(label) {
            hours = "0"
            minutes = "\(presetMinutes)"
            seconds = "0"
            store.setPresetDuration(seconds: presetMinutes * 60)
        }
        .buttonStyle(.bordered)
    }

    private func durationField(_ placeholder: String, text: Binding<String>) -> some View {
        TextField(placeholder, text: text)
            .keyboardType(.numberPad)
            .multilineTextAlignment(.center)
            .textFieldStyle(.roundedBorder)
            .frame(width: 50)
    }
}
