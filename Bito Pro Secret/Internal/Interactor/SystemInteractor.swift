import SwiftUI
import Ditto

struct SystemInteractor {
    private let appstate: AppState
    private let repo: Repository
    
    init(appstate: AppState, repo: Repository) {
        self.appstate = appstate
        self.repo = repo
    }
}

extension SystemInteractor {
    func pushPopupText(_ v: String?) {
        System.async {
            appstate.pubPopupText.send(v)
        }
    }
    
    func pushOpenMenubarAppTrigger(_ v: Bool) {
        System.async {
            appstate.pubOpenMenubarAppTrigger.send(v)
        }
    }
    
    func pushPopupPanelOption(_ v: PopupPanelOption?) {
        System.async {
            appstate.pubPopupPanelOption.send(v)
        }
    }
}
