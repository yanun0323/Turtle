import SwiftUI

extension NSAppearance {
    static var light = NSAppearance(named: .aqua)
    static var dark = NSAppearance(named: .darkAqua)
    
    func int() -> Int {
        switch self {
            case Self.light:
                return 1
            case Self.dark:
                return 2
            default:
                return 0
        }
    }
    
    static func format(_ value: Int) -> NSAppearance? {
        switch value {
            case 1:
                return light
            case 2:
                return dark
            default:
                return nil
        }
    }
}
