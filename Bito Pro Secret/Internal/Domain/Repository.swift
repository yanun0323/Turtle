import SwiftUI
import Combine

protocol Repository: DataRepository, PreferenceRepository {}

protocol DataRepository {
    func tx<T>(_ action: () throws -> T?) throws -> T? where T: Any
    
    func getLastButtonStoreOrder() throws -> Int
    func listUserButton() throws -> [UserButton]
    func getUserButton(_ id: Int64) throws -> UserButton?
    func createUserButton(_ s: UserButton) throws -> Int64
    func updateUserButton(_ id: Int64, _ s: UserButton) throws
    func deleteUserButton(_ id: Int64) throws
}

protocol PreferenceRepository {
    func getTransferedCoredata() throws -> Bool?
    func setTransferedCoredata(_ value: Bool) throws
    
    func subscribeCopyTimestampFormat(_ receiveValue: @escaping ((String?) -> Void)) throws -> AnyCancellable
    func getCopyTimestampFormat() throws -> String?
    func setCopyTimestampFormat(_ value: String) throws
    
    func getQuickSwitch() throws -> Bool?
    func setQuickSwitch(_ value: Bool) throws
    func subscibeQuickSwitch(_ handler: @escaping ((Bool?) -> Void)) throws -> AnyCancellable
    
    func getCloseAppAfterLink() throws -> Bool?
    func setCloseAppAfterLink(_ value: Bool) throws
    
    func getCloseAppAfterCopy() throws -> Bool?
    func setCloseAppAfterCopy(_ value: Bool) throws
    
    func getUseUnixForCopy() throws -> Bool?
    func setUseUnixForCopy(_ value: Bool) throws
    
    func getAppearance() throws -> Int?
    func setAppearance(_ value: Int) throws
    
    func getSecret() throws -> Secret?
    func setSecret(_ value: Secret) throws
}
