import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            hapticButton("💞 Hug", type: "hug") { HapticManager.shared.playHug() }
            hapticButton("🫀 Soft Heartbeat", type: "soft_heartbeat") { HapticManager.shared.playSoftHeartbeat() }
            hapticButton("🔥 Warmth", type: "warmth") { HapticManager.shared.playWarmth() }
            hapticButton("😂 Laughter", type: "laughter") { HapticManager.shared.playLaughter() }
            hapticButton("💔 Missing You", type: "missing_you") { HapticManager.shared.playMissingYou() }
            hapticButton("Pulse", type: "pulse") { HapticManager.shared.playPulse() }
            hapticButton("Heartbeat", type: "heartbeat") { HapticManager.shared.playHeartbeat() }
        }
        .padding()
    }

    func hapticButton(_ label: String, type: String, action: @escaping () -> Void) -> some View {
        Button(label) {
            action()
            WatchHapticSender.shared.send(type: type)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(12)
    }
}


//import SwiftUI
//
//struct ContentView: View {
//    var body: some View {
//        VStack(spacing: 20) {
//            Button("Play Heartbeat") {
//                HapticManager.shared.playHeartbeat()
//                WatchHapticSender.shared.send(type: "heartbeat")
//            }
//            Button("Play Pulse") {
//                HapticManager.shared.playPulse()
//                WatchHapticSender.shared.send(type: "pulse")
//            }
//        }
//        .padding()
//    }
//}
