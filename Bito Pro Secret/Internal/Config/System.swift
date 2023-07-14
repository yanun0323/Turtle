import SwiftUI

struct Config {
    static let VERSION = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    static let menubarSize: CGSize = CGSize(width: 400, height: 600)
    
    static let K8s = K8sCollection()
    static let Monitor = MonitorCollection()
    static let MySQL = MySQLCollection()
    static let Mongo = MongoCollection()
    static let Redis = RedisCollection()
    static let Bito = BitoCollection()
    static let Jenkins = JenkinsCollection()
    static let Animation = AnimationSet()
}

struct AnimationSet {
    static private let duration: Double = 0.2
    let Default = Animation.easeInOut(duration: duration)
    let EaseIn = Animation.easeIn(duration: duration)
    let EaseOut = Animation.easeOut(duration: duration)
}
