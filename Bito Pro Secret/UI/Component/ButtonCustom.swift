//
//  ButtonCopy.swift
//  Bito Pro Secret
//
//  Created by YanunYang on 2022/7/12.
//

import SwiftUI
import Ditto

enum ButtonStyle {
    case auto
    case blank
    case linked
}


struct ButtonCustom<V>: View where V: View {
    var width: CGFloat = 55
    var height: CGFloat = 22
    var color: Color = .background
    var radius: CGFloat = 5
    var border: CGFloat = 1.2
    var style: ButtonStyle = .blank
    var action: () -> Void
    var content: () -> V
    
    var body: some View {
        Button(action: action){
            RoundedRectangle(cornerRadius: radius)
                .shadow(radius: border)
                .foregroundColor(color)
                .frame(width: width, height: height)
                .overlay(content: content)
        }
        .customButtonStyle(style)
    }
}

extension View {
    func customButtonStyle(_ style: ButtonStyle) -> some View {
        switch style {
        case .auto:
            return AnyView(self.buttonStyle(.automatic))
        case .blank:
            return AnyView(self.buttonStyle(.plain))
        case .linked:
            return AnyView(self.buttonStyle(.link))
        }
    }
}


struct ButtonCopy: View {
    @Environment(\.injected) private var container
    @Environment(\.popOver) private var popOver
    var name: String = ""
    var copy: String
    var width: CGFloat = 55
    var height: CGFloat = 22
    var image: String? = nil
    var hook: (() -> Void)? = nil
    
    var body: some View {
        ButtonCustom(
            width: width,
            height: height) {
                container.interactor.copy(copy)
                container.interactor.system.pushPopupText("已複製")
                if let action = hook {
                    action()
                }
                if container.interactor.preference.getCloseAppAfterCopy() {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        popOver.close()
                    }
                }
            } content: {
                HStack(spacing: 3) {
                    if name.count == 0  {
                        Image(systemName: image ?? "doc.on.doc")
                    } else {
                        Text(name)
                        Image(systemName: image ?? "doc.on.doc")
                            .font(.caption2)
                            .foregroundColor(.primary25)
                    }
                }
            }
            .help(copy)
    }
}

struct ButtonPaste: View {
    var name: String = ""
    @Binding var paste: String
    var width: CGFloat = 55
    var height: CGFloat = 22
    var image: String? = nil
    var hook: (() -> Void)? = nil
    
    var body: some View {
        ButtonCustom(
            width: width,
            height: height) {
                guard let value = NSPasteboard.general.pasteboardItems?.first?.string(forType: .string) else { return }
                paste = value
                if let action = hook {
                    action()
                }
            } content: {
                HStack(spacing: 3) {
                    if name.count == 0  {
                        Image(systemName: image ?? "doc")
                    } else {
                        Text(name)
                        Image(systemName: image ?? "doc")
                            .font(.caption2)
                            .foregroundColor(.primary25)
                    }
                }
            }
    }
}

struct ButtonLink: View {
    @Environment(\.injected) private var container
    @Environment(\.popOver) private var popOver
    @Environment(\.openURL) private var openURL
    var name: String = ""
    var link: String
    var copy: String? = nil
    var width: CGFloat = 70
    var height: CGFloat = 25
    var image: String? = nil
    var hook: (() -> Void)? = nil
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .shadow(radius: 1.2)
                .foregroundColor(.background)
                .frame(width: width, height: height)
                .overlay {
                    HStack(spacing: 3) {
                        if name.count == 0 {
                            Image(systemName: image ?? "link")
                        } else {
                            Text(name)
                            Image(systemName: image ?? "link")
                                .font(.caption2)
                        }
                    }
                    .foregroundColor(.link)
                }
                .help(copy == nil ? link : "LINK: \(link)\nCOPY: \(getCopyString() ?? "-")")
                .gesture( TapGesture().onEnded({ _ in handleClick() }) )
                .contextMenu {
                    Button("拷貝連結到剪貼簿") {
                        container.interactor.copy(link)
                    }
                }
            if copy != nil {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(LinearGradient(colors: [.link, .glue], startPoint: .topLeading, endPoint: .trailing), style: StrokeStyle(lineWidth: 2))
                    .frame(width: width, height: height)
            }
        }
    }
    
    func handleClick(cmd: Bool = false) {
        defer {
            openURL(URL(string: link)!)
        }
        
        guard let stringToCopy = copy else { return }
        
        if stringToCopy == "*" {
            container.interactor.copyTimestamp()
        } else {
            container.interactor.copy(stringToCopy)
        }
        
        if let action = hook {
            action()
        }
        
        if container.interactor.preference.getCloseAppAfterLink() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                popOver.close()
            }
        }
    }
    
    func getCopyString() -> String? {
        if copy == "*" { return container.interactor.timestamp() }
        return copy
    }
}

