import CoreHaptics

class HapticManager {
    static let shared = HapticManager()
    private var engine: CHHapticEngine?
    
    private init() {
        prepareHaptics()
    }
    
    private func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("Haptic engine Error: \(error.localizedDescription)")
        }
    }
    
    func play(events: [CHHapticEvent]) {
        guard let engine = engine else { return }
        do {
            try engine.start()
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: 0)
        } catch {
            print("Failed to play haptic: \(error.localizedDescription)")
        }
    }
    
    // Emotion haptics
    func playHug() {
        play(events: [
            CHHapticEvent(eventType: .hapticContinuous,
                          parameters: [.init(parameterID: .hapticIntensity, value: 0.3),
                                       .init(parameterID: .hapticSharpness, value: 0.2)],
                          relativeTime: 0,
                          duration: 1.5),
            CHHapticEvent(eventType: .hapticTransient,
                          parameters: [.init(parameterID: .hapticIntensity, value: 0.3)],
                          relativeTime: 1.6),
            CHHapticEvent(eventType: .hapticTransient,
                          parameters: [.init(parameterID: .hapticIntensity, value: 0.25)],
                          relativeTime: 2.0)
        ])
    }
    
    func playSoftHeartbeat() {
        play(events: [
            CHHapticEvent(eventType: .hapticTransient,
                          parameters: [.init(parameterID: .hapticIntensity, value: 0.5)],
                          relativeTime: 0),
            CHHapticEvent(eventType: .hapticTransient,
                          parameters: [.init(parameterID: .hapticIntensity, value: 0.4)],
                          relativeTime: 0.25)
        ])
    }
    
    func playWarmth() {
        play(events: [
            CHHapticEvent(eventType: .hapticContinuous,
                          parameters: [.init(parameterID: .hapticIntensity, value: 0.2),
                                       .init(parameterID: .hapticSharpness, value: 0.1)],
                          relativeTime: 0,
                          duration: 2.0)
        ])
    }
    
    func playLaughter() {
        let events = stride(from: 0.0, to: 1.0, by: 0.15).map {
            CHHapticEvent(eventType: .hapticTransient,
                          parameters: [.init(parameterID: .hapticIntensity, value: 0.5)],
                          relativeTime: $0)
        }
        play(events: events)
    }
    
    func playMissingYou() {
        play(events: [
            CHHapticEvent(eventType: .hapticTransient,
                          parameters: [.init(parameterID: .hapticIntensity, value: 0.6)],
                          relativeTime: 0),
            CHHapticEvent(eventType: .hapticContinuous,
                          parameters: [.init(parameterID: .hapticIntensity, value: 0)],
                          relativeTime: 0.1,
                          duration: 0.9),
            CHHapticEvent(eventType: .hapticTransient,
                          parameters: [.init(parameterID: .hapticIntensity, value: 0.5)],
                          relativeTime: 1.0),
            CHHapticEvent(eventType: .hapticTransient,
                          parameters: [.init(parameterID: .hapticIntensity, value: 0.2)],
                          relativeTime: 1.5)
        ])
    }
    func playPulse() {
            guard let engine = engine else { return }
            let events = [
                CHHapticEvent(eventType: .hapticTransient,
                              parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 1),
                                           CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5)],
                              relativeTime: 0),
                CHHapticEvent(eventType: .hapticTransient,
                              parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.8),
                                           CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5)],
                              relativeTime: 0.2)
            ]
            play(events: events)
        }
    func playHeartbeat() {
            guard let engine = engine else { return }
            let events = [
                CHHapticEvent(eventType: .hapticTransient,
                              parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 1),
                                           CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.3)],
                              relativeTime: 0),
                CHHapticEvent(eventType: .hapticTransient,
                              parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 1),
                                           CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.3)],
                              relativeTime: 0.2)
            ]
            play(events: events)
        }
}

//import CoreHaptics
//
//class HapticManager {
//    static let shared = HapticManager()
//    private var engine: CHHapticEngine?
//
//    private init() {
//        prepareHaptics()
//    }
//
//    private func prepareHaptics() {
//        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
//        do {
//            engine = try CHHapticEngine()
//            try engine?.start()
//        } catch {
//            print("Haptic engine Error: \(error.localizedDescription)")
//        }
//    }
//
//    func playPulse() {
//        guard let engine = engine else { return }
//        let events = [
//            CHHapticEvent(eventType: .hapticTransient,
//                          parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 1),
//                                       CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5)],
//                          relativeTime: 0),
//            CHHapticEvent(eventType: .hapticTransient,
//                          parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.8),
//                                       CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.5)],
//                          relativeTime: 0.2)
//        ]
//        play(events: events)
//    }
//
//    func playHeartbeat() {
//        guard let engine = engine else { return }
//        let events = [
//            CHHapticEvent(eventType: .hapticTransient,
//                          parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 1),
//                                       CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.3)],
//                          relativeTime: 0),
//            CHHapticEvent(eventType: .hapticTransient,
//                          parameters: [CHHapticEventParameter(parameterID: .hapticIntensity, value: 1),
//                                       CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.3)],
//                          relativeTime: 0.2)
//        ]
//        play(events: events)
//    }
//
//    private func play(events: [CHHapticEvent]) {
//        guard let engine = engine else { return }
//        do {
//            let pattern = try CHHapticPattern(events: events, parameters: [])
//            let player = try engine.makePlayer(with: pattern)
//            try player.start(atTime: 0)
//        } catch {
//            print("Failed to play haptic: \(error.localizedDescription)")
//        }
//    }
//}
