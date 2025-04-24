//
//  WatchSessionManager.swift
//  AppleLoopsHaptic
//
//  Created by admin40 on 21/04/25.
//

//  This file manages the communication between the iOS app and the watch app.
//  It handles the reception of messages from the iOS app and plays the corresponding haptic feedback on the watch.
//  It uses the WatchConnectivity framework to establish a session and send messages.
//  The class conforms to WCSessionDelegate and ObservableObject protocols.
//  It also uses the WKInterfaceDevice class to play haptic feedback on the watch.
//  It is initialized when the app starts and activates the session if supported.
//  The class handles different types of haptic feedback based on the message received from the iOS app.

import WatchConnectivity
import WatchKit

class WatchSessionManager: NSObject, WCSessionDelegate, ObservableObject {
    override init() {
        super.init()
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }

    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if let type = message["haptic"] as? String {
            DispatchQueue.main.async {
                self.playMappedHaptic(type)
            }
        }
    }

    private func playMappedHaptic(_ type: String) {
        switch type {
        case "heartbeat", "soft_heartbeat":
            play(.directionUp)
            play(.directionUp, after: 0.25)

        case "pulse":
            play(.directionUp)
            play(.directionUp, after: 0.2)

        case "hug":
            play(.start)
            play(.directionDown, after: 1.5)
            play(.directionDown, after: 2.0)

        case "warmth":
            play(.directionDown)
            play(.directionDown, after: 0.5)
            play(.directionDown, after: 1.0)

        case "laughter":
            for i in 0..<5 {
                play(.click, after: Double(i) * 0.15)
            }

        case "missing_you":
            play(.failure)
            play(.notification, after: 1.0)
            play(.click, after: 1.5)

        default:
            break
        }
    }

    private func play(_ type: WKHapticType, after delay: TimeInterval = 0) {
        if delay == 0 {
            WKInterfaceDevice.current().play(type)
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                WKInterfaceDevice.current().play(type)
            }
        }
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}
}


//import WatchConnectivity
//import WatchKit
//
//class WatchSessionManager: NSObject, WCSessionDelegate, ObservableObject {
//    override init() {
//        super.init()
//        if WCSession.isSupported() {
//            WCSession.default.delegate = self
//            WCSession.default.activate()
//        }
//    }
//
//    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
//        if let type = message["haptic"] as? String {
//            DispatchQueue.main.async {
//                switch type {
//                case "heartbeat":
//                    self.playHeartbeat()
//                case "pulse":
//                    self.playPulse()
//                default:
//                    break
//                }
//            }
//        }
//    }
//
//    func playPulse() {
//        WKInterfaceDevice.current().play(.directionUp)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//            WKInterfaceDevice.current().play(.directionUp)
//        }
//    }
//
//    func playHeartbeat() {
//        WKInterfaceDevice.current().play(.success)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//            WKInterfaceDevice.current().play(.success)
//        }
//    }
//
//    // Required WCSessionDelegate methods:
//    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}
////    func sessionDidBecomeInactive(_ session: WCSession) {}
////    func sessionDidDeactivate(_ session: WCSession) {}
//}
