import SwiftUI
import SQLite
import Sworm

extension UserButton: Migrator {
    static var table: Tablex { return .init("user_buttons") }
    
    static var id = Expression<Int64>("id")
    static var style = Expression<UserButtonStyle>("style")
    static var name = Expression<String>("name")
    static var content = Expression<String>("content")
    static var order = Expression<Int>("order")
    
    static func migrate(_ conn: Connection) throws {
        try conn.run(table.create(ifNotExists: true) { t in
            t.column(id, primaryKey: .autoincrement)
            t.column(style)
            t.column(name)
            t.column(content)
            t.column(order)
        })
        
        try conn.run(table.createIndex(name, ifNotExists: true))
    }
    
    static func parse(_ r: Row) throws -> UserButton {
        return UserButton(
            id: try r.get(id),
            style: try r.get(style),
            name: try r.get(name),
            content: try r.get(content),
            order: try r.get(order)
        )
    }

    func setter() -> [Setter] {
        return [
            UserButton.name <- name,
            UserButton.style <- style,
            UserButton.content <- content,
            UserButton.order <- order
        ]
    }
}
