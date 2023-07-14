//
//  TextLink.swift
//  Bito Pro Secret
//
//  Created by YanunYang on 2022/7/13.
//

import Foundation
import SwiftUI

struct TextLink: View {
    @Environment(\.openURL) private var openURL
    var name: String
    var link: String
    var copy: String? = nil
    var width: CGFloat = 80
    var image: String? = nil
    var trailing: Bool = false
    var hook: (() -> Void)? = nil
    
    var body: some View {
        HStack {
            if !trailing {
                ButtonLink(link: link, copy: copy, width: 35, image: image, hook: hook)
            }
            Text(name)
                .font(.system(size: 16, weight: .regular, design: .rounded))
                .frame(width: width, alignment: .leading)
                .minimumScaleFactor(0.8)
                .lineLimit(1)
            if trailing {
                ButtonLink(link: link, copy: copy, width: 35, hook: hook)
            }
        }
    }
}

struct TextLink_Previews: PreviewProvider {
    static var previews: some View {
        TextLink(name: "Name", link: "Link")
    }
}
