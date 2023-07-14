import SwiftUI
import SQLite

extension UserButtonStyle: Value {
    typealias Datatype = String
    
    static var declaredDatatype: String {
        return String.declaredDatatype
    }
    
    static func fromDatatypeValue(_ datatypeValue: String) -> UserButtonStyle {
        return UserButtonStyle(rawValue: datatypeValue) ?? .Unknown
    }
    
    var datatypeValue: String {
        return self.rawValue
    }
}
