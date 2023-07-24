//
//  Setting.swift
//  Bito Pro Secret
//
//  Created by YanunYang on 2022/7/21.
//

import SwiftUI
import Ditto

struct Setting: View {
    @Environment(\.injected) private var container
    @State private var appearance: Int = 0
    @State private var closeAppAfterCopy: Bool = false
    @State private var closeAppAfterLink: Bool = false
    @State private var useUnixForCopy: Bool = false
    @State private var quickSwitch: Bool = false
    
    var body: some View {
        scrollView {
            VStack(alignment: .leading, spacing: 20) {
                themeBlock()
                
                toggle("拷貝後隱藏小工具", isOn: $closeAppAfterCopy)
                toggle("開啟連結後隱藏小工具", isOn: $closeAppAfterLink)
                toggle("使用Unix複製時間", isOn: $useUnixForCopy)
                toggle("使用快速切換", isOn: $quickSwitch)
                
                Spacer()
                
                shutdownBlock()
            }
        }
        .onAppear { handleOnAppear() }
        .onChange(of: closeAppAfterCopy) { container.interactor.preference.setCloseAppAfterCopy($0) }
        .onChange(of: closeAppAfterLink) { container.interactor.preference.setCloseAppAfterLink($0) }
        .onChange(of: useUnixForCopy) { container.interactor.preference.setUseUnixForCopy($0) }
        .onChange(of: quickSwitch) { container.interactor.preference.setQuickSwitch($0) }
        
    }
    
    @ViewBuilder
    private func toggle(_ title: String, isOn: Binding<Bool>) -> some View {
        Toggle(isOn: isOn) {
            Text(title)
        }
    }
    
    @ViewBuilder
    private func shutdownBlock() -> some View {
        HStack {
            Spacer()
            ButtonCustom(width: 100, height: 25, color: .red) {
                NSApplication.shared.terminate(self)
            } content: {
                Label {
                    Text("關閉軟體")
                } icon: {
                    Image(systemName: "power")
                }.foregroundColor(.white)
            }
            Spacer()
        }
    }
    
    @ViewBuilder
    private func themeBlock() -> some View {
        section("外觀", font: .body) {
            HStack(spacing: 20) {
                Spacer()
                VStack(spacing: 10) {
                    ButtonCustom(width: 60, height: 40, radius: 5) {
                        withAnimation(Config.Animation.Default) {
                            NSApp.appearance = nil
                            appearance = 0
                            container.interactor.preference.setAppearance(0)
                        }
                    } content: {
                        ZStack {
                            lightImage()
                                .mask {
                                    HStack(spacing: 0) {
                                        Rectangle()
                                            .frame(width: 29.5)
                                        Spacer()
                                    }
                                }
                            darkImage()
                                .offset(x: 30, y: 0)
                                .mask {
                                    HStack(spacing: 0) {
                                        Spacer()
                                        Rectangle()
                                            .frame(width: 29.5)
                                    }
                                }
                        }
                        .cornerRadius(5)
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.accentColor, style: StrokeStyle(lineWidth: 3))
                            .opacity(appearance == 0 ? 1 : 0)
                    )
                    Text("系統")
                }
                VStack(spacing: 10)  {
                    ButtonCustom(width: 60, height: 40, radius: 5) {
                        withAnimation(Config.Animation.Default) {
                            NSApp.appearance = NSAppearance(named: .aqua)
                            appearance = 1
                            container.interactor.preference.setAppearance(1)
                        }
                    } content: {
                        lightImage()
                            .cornerRadius(5)
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.accentColor, style: StrokeStyle(lineWidth: 3))
                            .opacity(appearance == 1 ? 1 : 0)
                )
                    Text("淺色")
                }
                VStack(spacing: 10)  {
                    ButtonCustom(width: 60, height: 40, radius: 5) {
                        withAnimation(Config.Animation.Default) {
                            NSApp.appearance = NSAppearance(named: .darkAqua)
                            appearance = 2
                            container.interactor.preference.setAppearance(2)
                        }
                    } content: {
                        darkImage()
                            .cornerRadius(5)
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.accentColor, style: StrokeStyle(lineWidth: 2.5))
                            .opacity(appearance == 2 ? 1 : 0)
                    )
                    Text("深色")
                }
                Spacer()

            }
        }
    }
    
    @ViewBuilder
    private func lightImage() -> some View {
        Image("Light")
            .resizable()
            .overlay {
                ZStack {
                    Rectangle()
                        .frame(height: 10)
                        .foregroundColor(Color.black.opacity(0.3))
                        .offset(x: 0, y: -20)
                    ZStack {
                        VStack {
                            HStack(spacing: 3) {
                                Circle()
                                    .foregroundColor(.red)
                                    .frame(width: 5, height: 5)
                                Circle()
                                    .foregroundColor(.yellow)
                                    .frame(width: 5, height: 5)
                                Circle()
                                    .foregroundColor(.green)
                                    .frame(width: 5, height: 5)
                                Spacer()
                            }
                            .padding(3)
                            Spacer()
                        }
                        HStack(spacing: 0) {
                            Spacer()
                            Rectangle()
                                .foregroundColor(.white)
                                .frame(width: 30)
                        }
                    }
                    .frame(width: 60, height: 40)
                    .background(Color.white.opacity(0.7))
                    .cornerRadius(5)
                    .offset(x: 10, y: 20)
                }
            }
            .clipShape(Rectangle())
    }
    
    @ViewBuilder
    private func darkImage() -> some View {
        Image("Dark")
            .resizable()
            .overlay {
                ZStack {
                    Rectangle()
                        .frame(height: 10)
                        .foregroundColor(Color.black.opacity(0.3))
                        .offset(x: 0, y: -20)
                    VStack {
                        HStack(spacing: 3) {
                            Circle()
                                .foregroundColor(.red)
                                .frame(width: 5, height: 5)
                            Circle()
                                .foregroundColor(.yellow)
                                .frame(width: 5, height: 5)
                            Circle()
                                .foregroundColor(.green)
                                .frame(width: 5, height: 5)
                            Spacer()
                        }
                        .padding(3)
                        Spacer()
                    }
                    .frame(width: 60, height: 40)
                    .background(Color.black.opacity(0.8))
                    .cornerRadius(5)
                    .offset(x: 10, y: 20)
                }
            }
            .clipShape(Rectangle())
    }
}

extension Setting {
    func handleOnAppear() {
        appearance = container.interactor.preference.getAppearance()?.int() ?? 0
        closeAppAfterCopy = container.interactor.preference.getCloseAppAfterCopy()
        closeAppAfterLink = container.interactor.preference.getCloseAppAfterLink()
        useUnixForCopy = container.interactor.preference.getUseUnixForCopy()
        quickSwitch = container.interactor.preference.getQuickSwitch()
    }
}

#if Debug
struct Setting_Previews: PreviewProvider {
    static var previews: some View {
        Setting()
            .frame(size: Config.menubarSize)
    }
}
#endif
