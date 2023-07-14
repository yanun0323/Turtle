//
//  ButtonData.swift
//  Bito Pro Secret
//
//  Created by YanunYang on 2022/7/17.
//

import Foundation
import CoreData

public class ButtonData: NSManagedObject {
    @NSManaged public var styleStr: String
    @NSManaged public var name: String
    @NSManaged public var content: String
    @NSManaged public var order: Int32
}

extension ButtonData {
    var Style: UserButtonStyle {
            get {
                return UserButtonStyle(rawValue: styleStr) ?? .Copy
            }

            set {
                self.styleStr = newValue.rawValue
            }
        }
}
//
//extension ButtonData {
//    func toUserButton() -> UserButton {
//        return UserButton(
//            style: self.Style,
//            name: self.name,
//            content: self.content,
//            order: Int(self.order)
//        )
//    }
//}
