
import WatchConnectivity

class WatchHapticSender: NSObject, WCSessionDelegate {
    static let shared = WatchHapticSender()
    
    override private init() {
        super.init()
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }

    func send(type: String) {
        if WCSession.default.isReachable {
            WCSession.default.sendMessage(["haptic": type], replyHandler: nil)
        }
    }

    // Required delegate methods
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}
    func sessionDidBecomeInactive(_ session: WCSession) {}
    func sessionDidDeactivate(_ session: WCSession) {}
}
