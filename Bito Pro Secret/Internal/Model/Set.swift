import SwiftUI

struct LinkSet: Hashable {
    var title: String
    var link: String
    var copy: String?
    var image: String?
    
    init(_ title: String, _ link: String, copy: String? = nil, img image: String? = nil) {
        self.title = title
        self.link = link
        self.copy = copy
        self.image = image
    }
}

struct CopySet: Hashable {
    var title: String
    var text: String
    var sub: String?
    var needUpdate: Bool
    var image: String?
    
    init(_ title: String, _ text: String, sub: String? = nil, img image: String? = nil, needUpdate: Bool = false) {
        self.title = title
        self.text = text
        self.sub = sub
        self.needUpdate = false
        self.image = image
    }
}

struct CopySets: Hashable {
    var title: String
    var texts: [String]
    var subs: [String?]
    var images: [String?]
    var needUpdate: Bool
    
    init(_ title: String, _ texts: [String], subs: [String?] = [], imgs images: [String?] = [], needUpdate: Bool = false) {
        self.title = title
        self.texts = texts
        self.subs = subs
        self.images = images
        self.needUpdate = false
    }
}
