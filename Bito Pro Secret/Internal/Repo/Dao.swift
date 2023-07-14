import SwiftUI
import Sworm

struct Dao: DataDao, PreferenceDao {
    init() {
        SQL.getDriver().migrate([
            UserButton.self
        ])
    }
}

extension Dao: Repository {}
