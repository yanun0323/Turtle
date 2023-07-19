import SwiftUI
import Ditto

extension Interactor {
    func copyTimestamp() {
        copy(timestamp())
    }
    
    func timestamp() -> String {
        if preference.getUseUnixForCopy() {
            return Date.now.timeIntervalSince1970.seconds.description
        }
        return Date.now.string(preference.getCopyTimestampFormat())
    }
    
    func copy(_ stringToCopy: String) {
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(stringToCopy, forType: .string)
    }
}
