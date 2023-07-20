import SwiftUI
import Sworm

struct Dao: DataDao, PreferenceDao {
    init() {
        _ = SQL.setup(isMock: false)
        
        SQL.getDriver().migrate([
            UserButton.self
        ])
    }
}

extension Dao: Repository {}
