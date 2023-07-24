import SwiftUI
import Ditto

extension ButtonPanel {
    enum FocusField {
        case name, content
    }
}


struct ButtonPanel: View {
    @Environment(\.injected) private var container
    @FocusState private var focusField: FocusField?
    
    @State var inputID: Int64? = nil
    @State private var inputName: String = ""
    @State private var inputStyle: UserButtonStyle = .Copy
    @State private var inputContent: String = ""
    
    var body: some View {
        ZStack {
            cover()
            userButtonPanel()
        }
        .hotkeys([
            Hotkey(keyBase: [], key: .kVK_Return, action: confirm),
            Hotkey(keyBase: [.command], key: .kVK_Return, action: confirm),
            Hotkey(keyBase: [.command], key: .kVK_ANSI_1, action: { inputStyle = .Copy }),
            Hotkey(keyBase: [.command], key: .kVK_ANSI_2, action: { inputStyle = .Link })
        ])
        .textEditerCommand()
        .onAppear { handleOnAppear() }
        .ignoresSafeArea(.all)
    }
    
    @ViewBuilder
    private func cover() -> some View {
        Rectangle()
            .foregroundColor(.black.opacity(0.5))
    }
    
    @ViewBuilder
    private func userButtonPanel() -> some View {
        VStack {
            HStack {
                Text("按鈕類型")
                Picker(selection: $inputStyle) {
                    ForEach(UserButtonStyle.allCases) { type in
                        if type != .Unknown {
                            Text(type.rawValue).tag(type)
                        }
                    }
                } label: {}
                    .background(.background)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
            }
            
            Text("⌘+1 Copy    ⌘+2 Link")
                .font(.system(size: 10))
                .foregroundColor(.primary25)
            
            HStack {
                Text("按鈕名稱")
                TextField("google 首頁", text: $inputName)
                    .focused($focusField, equals: .name)
            }
            HStack {
                VStack {
                    Text(inputStyle == .Copy ? "拷貝內容" : "連結網址")
                    Spacer()
                }
                TextEditor(text: $inputContent)
                    .font(.system(size: 12.5))
                    .background(
                        ZStack {
                            Color.section.opacity(0.6)
                                .border(Color.section.opacity(0.5), width: 1)
                            if inputContent.count == 0 {
                                VStack {
                                    HStack {
                                        Text("https://www.google.com")
                                            .colorMultiply(.primary)
                                            .opacity(0.25)
                                            .font(.system(size: 12.5))
                                            .padding(.leading, 3)
                                        Spacer()
                                    }
                                    Spacer()
                                }
                            }
                        }
                    )
                    .focused($focusField, equals: .content)
            }
            .frame(maxHeight: 100)
            
            Text("⌘+Enter 可直接\(inputID.isNil ?"新增":"確認修改")")
                .font(.system(size: 10))
                .foregroundColor(.primary25)
                .padding(.bottom, 10)
            
            let buttonWidth: CGFloat = 100
            let buttonHeight: CGFloat = 25
            let buttonRadius: CGFloat = 5
            
            HStack {
                cancelButton(buttonWidth, buttonHeight, buttonRadius)
                confirmButton(buttonWidth, buttonHeight, buttonRadius)
            }
        }
        .padding()
        .background(Color.background)
        .cornerRadius(7)
        .padding(.horizontal, 30)
    }
    
    @ViewBuilder
    private func cancelButton(_ width: CGFloat, _ height: CGFloat, _ radius: CGFloat) -> some View {
        Button(width: width, height: height, color: .section, radius: radius) {
            dismiss()
        } content: {
            Text("取消")
                .foregroundColor(.gray)
        }
    }
    
    @ViewBuilder
    private func confirmButton(_ width: CGFloat, _ height: CGFloat, _ radius: CGFloat) -> some View {
        Button(width: width, height: height, color: .blue, radius: radius) {
            confirm()
        } content: {
            Text(inputID.isNil ? "新增" : "修改")
                .foregroundColor(.white)
        }
        .disabled(isDisableConfirm())
    }
    
}
    
extension ButtonPanel {
    
    private func handleOnAppear() {
        focusField = .name
        guard let id = inputID else { return }
        guard let button = container.interactor.data.getUserButton(id) else { return }
        inputName = button.name
        inputStyle = button.style
        inputContent = button.content
    }
    
    private func resetInput() {
        inputID = nil
        inputName = ""
        inputStyle = .Copy
        inputContent = ""
    }
    
    private func createUserButton() -> UserButton {
        return UserButton(style: inputStyle, name: inputName, content: inputContent)
    }
    
    private func isDisableConfirm() -> Bool {
        return inputName.isEmpty || inputContent.isEmpty
    }
    
    private func dismiss() {
        container.interactor.system.pushPopupPanelOption(nil)
    }
    
    private func confirm() {
        defer { dismiss() }
        if inputID.isNil { /* craete button */
            _ = container.interactor.data.createUserButton(createUserButton())
            container.interactor.data.pushUserButtonList()
            return
        }
        
        /* confirm edit button */
        guard let id = inputID else { return }
        container.interactor.data.updateUserButton(id, createUserButton())
        container.interactor.data.pushUserButtonList()
    }
    
}

#if Debug
struct ButtonPanel_Previews: PreviewProvider {
    static var previews: some View {
        ButtonPanel()
    }
}
#endif
