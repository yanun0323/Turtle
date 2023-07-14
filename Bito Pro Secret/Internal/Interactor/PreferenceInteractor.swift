import SwiftUI
import Combine
import Ditto

struct PreferenceInteractor {
    private let appstate: AppState
    private let repo: Repository
    
    init(appstate: AppState, repo: Repository) {
        self.appstate = appstate
        self.repo = repo
    }
}

extension PreferenceInteractor {
    func getTransferedCoredata() -> Bool {
        System.doCatch("get transfered core data") {
            return try repo.getTransferedCoredata() ?? false
        } ?? false
    }
    
    func setTransferedCoredata(_ value: Bool) {
        System.doCatch("set transfered core data") {
            try repo.setTransferedCoredata(value)
        }
    }
    
    func subscribeCopyTimestampFormat(_ receiveValue: @escaping ((String?) -> Void)) -> AnyCancellable? {
        return System.doCatch("subscribe copy timestamp format") {
            return try repo.subscribeCopyTimestampFormat(receiveValue)
        }
    }
    
    func getCopyTimestampFormat() -> String {
        return System.doCatch("get copy timestamp format") {
            return try repo.getCopyTimestampFormat()
        } ?? "yyyy.MM.dd-hhmmss"
    }
    
    func setCopyTimestampFormat(_ value: String) {
        System.doCatch("set copy timestamp format") {
            try repo.setCopyTimestampFormat(value)
        }
    }
    
    func getQuickSwitch() -> Bool {
        return System.doCatch("get quick switch") {
            return try repo.getQuickSwitch()
        } ?? false
    }
    
    func setQuickSwitch(_ value: Bool) {
        System.doCatch("set quick switch") {
            try repo.setQuickSwitch(value)
            appstate.pubQuickSwitch.send(value)
        }
    }
    
    func subsQuickSwitch(_ handler: @escaping ((Bool?) -> Void)) -> AnyCancellable? {
        return System.doCatch("subsQuickSwitch") {
            return try repo.subscibeQuickSwitch(handler)
        } ?? nil
    }
    
    func getCloseAppAfterLink() -> Bool {
        return System.doCatch("get close app after link") {
            return try repo.getCloseAppAfterLink()
        } ?? false
    }
    
    func setCloseAppAfterLink(_ value: Bool) {
        System.doCatch("set close app after link") {
            try repo.setCloseAppAfterLink(value)
        }
    }
    
    func getCloseAppAfterCopy() -> Bool {
        return System.doCatch("get close app after cpoy") {
            return try repo.getCloseAppAfterCopy()
        } ?? false
    }
    
    func setCloseAppAfterCopy(_ value: Bool) {
        System.doCatch("set close app after copy") {
            try repo.setCloseAppAfterCopy(value)
        }
    }
    
    func getUseUnixForCopy() -> Bool {
        return System.doCatch("get use unix for copy") {
            return try repo.getUseUnixForCopy()
        } ?? false
    }
    
    func setUseUnixForCopy(_ value: Bool) {
        System.doCatch("set use unix for copy") {
            try repo.setUseUnixForCopy(value)
        }
    }
    
    func getAppearance() -> NSAppearance? {
        return System.doCatch("get appearance") {
            let appearance = try repo.getAppearance()
            switch appearance {
                case 1:
                    return NSAppearance(named: .aqua)
                case 2:
                    return NSAppearance(named: .darkAqua)
                default:
                    return nil
            }
        } ?? nil
    }
    
    func setAppearance(_ value: Int) {
        System.doCatch("set appearance") {
            try repo.setAppearance(value)
        }
    }
    
}
