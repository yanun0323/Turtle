import SwiftUI

extension ColorScheme {
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
    
    static func format(_ value: Int) -> ColorScheme? {
        switch value {
            case 1:
                return .light
            case 2:
                return .dark
            default:
                return nil
        }
    }
}
