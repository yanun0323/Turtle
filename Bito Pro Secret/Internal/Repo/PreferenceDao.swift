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
    
}

extension UserDefaults {
    @UserDefault(key: "AccentColor")
    static var accentColor: Color?
    
    @UserDefault(key: "TransferedCoredata")
    static var transferedCoredata: Bool?
    
    @UserDefault(key: "CopyTimestampFormat")
    static var copyTimestampFormat: String?
    
    @UserDefault(key: "QUICK_SWITCH")
    static var quickSwitch: Bool?
    
    @UserDefault(key: "SETTING_LINK")
    static var closeAppAfterLink: Bool?
    
    @UserDefault(key: "SETTING_COPY")
    static var closeAppAfterCopy: Bool?
    
    @UserDefault(key: "SETTING_BUTTON_CREATEAR")
    static var buttonCreater: Bool?
    
    @UserDefault(key: "SETTING_USE_UNIX")
    static var useUnixForCopy: Bool?
    
    @UserDefault(key: "SETTING_K8S_LINK_COPY_TOKEN")
    static var k8sLinkCopyToken: Bool?
    
    @UserDefault(key: "SETTING_Deploy_LINK_COPY_TS")
    static var deployLinkCopyTS: Bool?
    
    @UserDefault(key: "Theme", defaultValue: 0)
    static var appearance: Int?
}
