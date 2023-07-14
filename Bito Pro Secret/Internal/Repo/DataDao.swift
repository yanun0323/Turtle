import SwiftUI
import SQLite
import Sworm

protocol DataDao {}

extension DataDao where Self: DataRepository {
    func tx<T>(_ action: () throws -> T?) throws -> T? where T: Any {
        var result: T?
        try SQL.getDriver().transaction {
            result = try action()
        }
        return result
    }
    
    func getLastButtonStoreOrder() throws -> Int {
        let query = UserButton.table.order(UserButton.order.desc).select(UserButton.order)
        let results = try SQL.getDriver().prepare(query)
        for r in results {
            return try r.get(UserButton.order)
        }
        return 0
    }
    
    func listUserButton() throws -> [UserButton] {
        let query = UserButton.table
        let results = try SQL.getDriver().prepare(query)
        
        var UserButtons: [UserButton] = []
        for r in results {
            UserButtons.append(try UserButton.parse(r))
        }
        return UserButtons
    }
    
    func getUserButton(_ id: Int64) throws -> UserButton? {
        let query = UserButton.table.filter(id == UserButton.id)
        let results = try SQL.getDriver().prepare(query)
        for r in results {
            return try UserButton.parse(r)
        }
        
        return nil
    }
    
    func createUserButton(_ s: UserButton) throws -> Int64 {
        let insert = UserButton.table.insert(
            UserButton.name <- s.name,
            UserButton.style <- s.style,
            UserButton.content <- s.content,
            UserButton.order <- s.order
        )
        return try SQL.getDriver().run(insert)
    }
    
    func updateUserButton(_ id: Int64, _ s: UserButton) throws {
        let update = UserButton.table.filter(UserButton.id == id).update(
            UserButton.name <- s.name,
            UserButton.style <- s.style,
            UserButton.content <- s.content,
            UserButton.order <- s.order
        )
        try SQL.getDriver().run(update)
    }
    
    func deleteUserButton(_ id: Int64) throws {
        try SQL.getDriver().run(UserButton.table.filter(UserButton.id == id).delete())
    }
}
