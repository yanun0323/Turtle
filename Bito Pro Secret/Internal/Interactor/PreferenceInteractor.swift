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
    
    func getColorScheme() -> ColorScheme? {
        return System.doCatch("get appearance") {
            return ColorScheme.format(try repo.getAppearance() ?? 0)
        }
    }
    
    func setColorScheme(_ value: Int) {
        System.doCatch("set appearance") {
            try repo.setAppearance(value)
        }
        
        System.async {
            appstate.scheme.send(ColorScheme.format(value))
        }
    }
    
    func getSecret() -> Secret {
        return System.doCatch("get secret") {
            try repo.getSecret()
        } ?? .default
    }
    
    func setSecret(_ value: Secret) {
        System.doCatch("set secret") {
            try repo.setSecret(value)
        }
        
        System.async {
            appstate.secret.send(value)
        }
    }
}
