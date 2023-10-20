import SwiftUI
import Ditto

extension DIContainer {
    var appstate: AppState { AppState.get() }
    var interactor: Interactor { Interactor.get(isMock: self.isMock) }
}

struct Interactor {
    private static var `default`: Self? = nil
    
    let data: DataInteractor
    let system: SystemInteractor
    let preference: PreferenceInteractor
    let updater: UpdaterInteractor
    
    init(appstate: AppState, isMock: Bool) {
        let repo: Repository = Dao()
        
        self.data = DataInteractor(appstate: appstate, repo: repo)
        self.system = SystemInteractor(appstate: appstate, repo: repo)
        self.preference = PreferenceInteractor(appstate: appstate, repo: repo)
        self.updater = UpdaterInteractor(appstate: appstate, repo: repo)
        
        setup()
    }
}

extension Interactor {
    private func setup() {
        data.pushUserButtonList()
    }
}

extension Interactor {
    public static func get(isMock: Bool) -> Self {
        if Self.default.isNil {
            Self.default = Interactor(appstate: AppState.get(), isMock: isMock)
        }
        return Self.default!
    }
}
