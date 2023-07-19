import SwiftUI
import Ditto

extension CustomButton {
    enum FocusField {
        case name, content
    }
}

struct CustomButton: View {
    @Environment(\.injected) private var container
    @FocusState private var focusField: FocusField?
    @State private var buttons: [UserButton] = []
    
    var body: some View {
        VStack {
            header()
                .padding(.horizontal)
            buttonList()
        }
        .onAppear{ handleOnAppear() }
        .onReceive(container.appstate.pubUserButtonStore) { buttons = $0 }
    }
    
    @ViewBuilder
    private func header() -> some View {
        HStack {
            Block(width: 50, height: 20)
            Spacer()
            Text("對按鈕按右鍵可以進行修改")
                .foregroundColor(.primary50)
            Spacer()
            createButton()
        }
    }
    
    @ViewBuilder
    private func createButton() -> some View {
        Button(width: 50, height: 20, color: .background, radius: 5) {
            container.interactor.system.pushPopupPanelOption(.createButton)
        } content: {
            Image(systemName: "plus")
                .foregroundColor(.blue)
        }
    }
    
    @ViewBuilder
    private func buttonList() -> some View {
        scrollView {
            LazyVStack {
                ForEach(buttons) { b in
                    HStack(spacing: 15) {
                        let buttonWidth: CGFloat = 30
                        if b.style == .Link {
                            ButtonLink(link: b.content, width: buttonWidth)
                        } else {
                            ButtonCopy(copy: b.content, width: buttonWidth)
                        }
                        Text(b.name)
                            .lineLimit(1)
                            .font(.system(size: 16))
                            .frame(width: 200, alignment: .leading)
                    }
                    .background(Color.transparent)
                    .contextMenu {
                        Button("修改", role: .cancel) {
                            container.interactor.system.pushPopupPanelOption(.editButton(buttonID: b.id))
                        }
                        
                        Button("刪除", role: .destructive) {
                            container.interactor.system.pushPopupPanelOption(.deleteButton(buttonID: b.id))
                        }
                    }
                }
            }
        }
    }
    
}

extension CustomButton {
    
    private func handleOnAppear() {
        if buttons.isEmpty {
            container.interactor.data.pushUserButtonList()
        }
    }
    
}

struct CustomButton_Previews: PreviewProvider {
    static var previews: some View {
        CustomButton()
            .frame(size: Config.menubarSize)
    }
}
