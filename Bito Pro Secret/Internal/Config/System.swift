import SwiftUI

struct Config {
    static let VERSION = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    static let menubarSize: CGSize = CGSize(width: 400, height: 600)
    static let Animation = AnimationSet()
}

struct AnimationSet {
    static private let duration: Double = 0.2
    let Default = Animation.easeInOut(duration: duration)
    let EaseIn = Animation.easeIn(duration: duration)
    let EaseOut = Animation.easeOut(duration: duration)
}
