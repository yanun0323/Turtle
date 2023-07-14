//
//  UserButton.swift
//  Bito Pro Secret
//
//  Created by YanunYang on 2022/7/19.
//

import Foundation


struct UserButtonOld: Hashable, Identifiable {
    var id: Self { self }
    
    var Style: UserButtonStyle = .Copy
    var Name: String = ""
    var Content: String = ""
    var Order: Int32 = 0
}

extension UserButtonOld {
    func toUserButton() -> UserButton {
        return UserButton(
            style: self.Style,
            name: self.Name,
            content: self.Content,
            order: Int(self.Order)
        )
    }
}

enum UserButtonStyle: String, CaseIterable, Identifiable, Equatable {
    var id: Self { self }
    
    case Copy = "Copy"
    case Link = "Link"
    case Unknown = ""
}

struct UserButton {
    var id: Int64
    var style: UserButtonStyle
    var name: String
    var content: String
    var order: Int
    
    init(id: Int64 = 0, style: UserButtonStyle, name: String, content: String, order: Int = 0) {
        self.id = id
        self.style = style
        self.name = name
        self.content = content
        self.order = order
    }
    
    init(_ data: ButtonData){
        self.init(
            style: data.Style,
            name: data.name,
            content: data.content,
            order: Int(data.order)
        )
    }
}

extension UserButton: Hashable, Identifiable {}
