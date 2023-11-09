import SwiftUI
import CoreData
import Ditto

struct DataInteractor {
    private let appstate: AppState
    private let repo: Repository
    
    init(appstate: AppState, repo: Repository) {
        self.appstate = appstate
        self.repo = repo
    }
}

extension DataInteractor {
    func pushUserButtonList() {
        System.asyncio {
            return System.doCatch("push list UserButton") {
                return try repo.listUserButton()
            }
        } main: { value in
            if let value = value {
                appstate.pubUserButtonStore.send(value)
            }
        }
    }
    
    func listUserButton() -> [UserButton] {
        return System.doCatch("list UserButton") {
            try repo.listUserButton()
        } ?? []
    }
    
    func getUserButton(_ id: Int64) -> UserButton? {
        System.doCatch("get UserButton") {
            try repo.getUserButton(id)
        }
    }
    
    func createUserButton(_ s: UserButton) -> Int64? {
        return System.doCatch("create UserButton") {
            return try repo.tx {
                var b = s
                let order = try repo.getLastButtonStoreOrder()
                b.order = order+1
                return try repo.createUserButton(b)
            }
        } ?? nil
    }
    
    func updateUserButton(_ id: Int64, _ s: UserButton) {
        System.doCatch("update UserButton") {
            try repo.updateUserButton(id, s)
        }
    }
    
    func deleteUserButton(_ id: Int64) {
        System.doCatch("delete UserButton") {
            try repo.deleteUserButton(id)
        }
    }
}
