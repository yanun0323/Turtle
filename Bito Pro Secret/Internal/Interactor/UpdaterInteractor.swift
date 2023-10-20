import SwiftUI
import Sparkle

extension SPUStandardUpdaterController {
    static var shared = SPUStandardUpdaterController(startingUpdater: true, updaterDelegate: nil, userDriverDelegate: SPUUser.default)
}

class SPUUser: NSObject {
    static var `default` = SPUUser()
}

extension SPUUser: SPUStandardUserDriverDelegate {
    var supportsGentleScheduledUpdateReminders: Bool { true }
    func standardUserDriverShouldHandleShowingScheduledUpdate(_ update: SUAppcastItem, andInImmediateFocus immediateFocus: Bool) -> Bool {
        print("ShouldHandleShowingScheduledUpdate")
        return immediateFocus
    }
    
    func standardUserDriverWillHandleShowingUpdate(_ handleShowingUpdate: Bool, forUpdate update: SUAppcastItem, state: SPUUserUpdateState) {
        print("WillHandleShowingUpdate")
        SPUStandardUpdaterController.shared.userDriver.showUpdateInFocus()
    }
    
    func standardUserDriverDidReceiveUserAttention(forUpdate update: SUAppcastItem) {
        print("DidReceiveUserAttention")
    }
    
    func standardUserDriverWillFinishUpdateSession() {
        print("WillFinishUpdateSession")
        let updater = SPUStandardUpdaterController.shared.updater
        updater.resetUpdateCycle()
    }
}

struct UpdaterInteractor {
    private let appstate: AppState
    private let repo: Repository
    
    init(appstate: AppState, repo: Repository) {
        self.appstate = appstate
        self.repo = repo
    }
}

extension UpdaterInteractor {
    func getUpdater() -> SPUUpdater {
        return SPUStandardUpdaterController.shared.updater
    }
    
    func forceCheckForUpdates() {
        SPUStandardUpdaterController.shared.updater.checkForUpdates()
    }
    
    func checkForUpdates() {
        if SPUStandardUpdaterController.shared.updater.sessionInProgress {
            print("sessionInProgress")
            SPUStandardUpdaterController.shared.updater.checkForUpdates()
            return
        }
        SPUStandardUpdaterController.shared.updater.checkForUpdatesInBackground()
    }
}
