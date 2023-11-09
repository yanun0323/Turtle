import SwiftUI
import Combine
import Ditto

protocol PreferenceDao {}

extension PreferenceDao where Self: PreferenceRepository {
    
    func getAccentColor() throws -> Color? {
        return UserDefaults.accentColor
    }
    
    func setAccentColor(_ color: Color) throws {
        UserDefaults.accentColor = color
    }
    
    func getTransferedCoredata() throws -> Bool? {
        return UserDefaults.transferedCoredata
    }
    
    func setTransferedCoredata(_ value: Bool) throws {
        UserDefaults.transferedCoredata = value
    }
    
    func subscribeCopyTimestampFormat(_ receiveValue: @escaping ((String?) -> Void)) throws -> AnyCancellable {
       return  UserDefaults.$copyTimestampFormat.sink(receiveValue: receiveValue)
    }
    
    func getCopyTimestampFormat() throws -> String? {
        return UserDefaults.copyTimestampFormat
    }
    
    func setCopyTimestampFormat(_ value: String) throws {
        UserDefaults.copyTimestampFormat = value
    }
    
    func getQuickSwitch() throws -> Bool? {
        return UserDefaults.quickSwitch
    }
    
    func setQuickSwitch(_ value: Bool) throws {
        UserDefaults.quickSwitch = value
    }
    
    func subscibeQuickSwitch(_ handler: @escaping ((Bool?) -> Void)) throws -> AnyCancellable {
        return UserDefaults.$quickSwitch.sink(receiveValue: handler)
    }
    
    func getCloseAppAfterLink() throws -> Bool? {
        return UserDefaults.closeAppAfterLink
    }
    
    func setCloseAppAfterLink(_ value: Bool) throws {
        UserDefaults.closeAppAfterLink = value
    }
    
    func getCloseAppAfterCopy() throws -> Bool? {
        return UserDefaults.closeAppAfterCopy
    }
    
    func setCloseAppAfterCopy(_ value: Bool) throws {
        UserDefaults.closeAppAfterCopy = value
    }
    
    func getUseUnixForCopy() throws -> Bool? {
        return UserDefaults.useUnixForCopy
    }
    
    func setUseUnixForCopy(_ value: Bool) throws {
        UserDefaults.useUnixForCopy = value
    }
    
    func getAppearance() throws -> Int? {
        return UserDefaults.appearance
    }
    
    func setAppearance(_ value: Int) throws {
        UserDefaults.appearance = value
    }
    
    func getSecret() throws -> Secret? {
        guard let data = UserDefaults.secret?.data(using: .utf8) else { return nil }
        return try JSONDecoder().decode(Secret.self, from: data)
    }
    
    func setSecret(_ value: Secret) throws {
        UserDefaults.secret = String(data: try JSONEncoder().encode(value), encoding: .utf8)
    }
}

extension UserDefaults {
    static let application = UserDefaults(suiteName: "bitopro.turtle.yanunyang.com")!
    
    @UserDefaultState(key: "AccentColor", .application)
    static var accentColor: Color?
    
    @UserDefaultState(key: "TransferedCoredata", .application)
    static var transferedCoredata: Bool?
    
    @UserDefaultState(key: "CopyTimestampFormat", .application)
    static var copyTimestampFormat: String?
    
    @UserDefaultState(key: "QUICK_SWITCH", .application)
    static var quickSwitch: Bool?
    
    @UserDefaultState(key: "SETTING_LINK", .application)
    static var closeAppAfterLink: Bool?
    
    @UserDefaultState(key: "SETTING_COPY", .application)
    static var closeAppAfterCopy: Bool?
    
    @UserDefaultState(key: "SETTING_BUTTON_CREATEAR", .application)
    static var buttonCreater: Bool?
    
    @UserDefaultState(key: "SETTING_USE_UNIX", .application)
    static var useUnixForCopy: Bool?
    
    @UserDefaultState(key: "SETTING_K8S_LINK_COPY_TOKEN", .application)
    static var k8sLinkCopyToken: Bool?
    
    @UserDefaultState(key: "SETTING_Deploy_LINK_COPY_TS", .application)
    static var deployLinkCopyTS: Bool?
    
    @UserDefaultState(key: "Theme", defaultValue: 0, .application)
    static var appearance: Int?
    
    @UserDefaultState(key: "USER_SECRET", .application)
    static var secret: String?
}
