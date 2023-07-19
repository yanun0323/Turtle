import SwiftUI
import Ditto

// MARK: Main
struct ContentView: View {
    @Environment(\.injected) private var container
    @Environment(\.openURL) private var openURL
    
    @FocusState private var focus: Bool
    @State private var textField: String = ""
    @State private var lastPage: Int = 0
    @State private var page: Int = 0
    @State private var shutdowning: Bool = false
    @State private var popupText: String = ""
    @State private var showPopup: Bool = false
    @State private var tranferCoredata: Bool = false
    @State private var quickSwitch: Bool = false
    @State private var showWhatsNew: Bool = false
    
    @State private var isInit: Bool = false
    
    @State private var popupPanelOption: PopupPanelOption? = nil
    var showPopupSecond: UInt32 = 1
    
    var body: some View {
        ZStack {
            mainView()
                .disabled(shutdowning)
            
            textPopup()
            
            cover()
                .opacity(popupPanelOption != nil ? 1 : 0)
            drawPopupPanel(popupPanelOption)
                .opacity(popupPanelOption != nil ? 1 : 0)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.focus = true
            }
            handleAppearAction()
        }
        .onReceive(container.appstate.pubOpenMenubarAppTrigger) { isOpen in
            if !isOpen { return }
            handleAppearAction()
        }
        .onReceive(container.appstate.pubFocus) { newValue in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                print("Change focus \(newValue)")
                self.focus = true
            }
        }
        .onReceive(container.appstate.pubPopupText) { v in
            withAnimation(Config.Animation.Default) {
                popupText = v ?? ""
                showPopup = !v.isNil
            }
            if v.isNil {
                return
            }
            DispatchQueue.global(qos: .background).async {
                sleep(showPopupSecond)
                container.interactor.system.pushPopupText(nil)
            }
        }
        .onReceive(container.appstate.pubPopupPanelOption) { popupPanelOption = $0 }
        .onReceive(container.appstate.pubQuickSwitch) { quickSwitch = $0 }
        .background(.background.opacity(0.3))
    }
    
    @ViewBuilder
    private func cover() -> some View {
        Color.background2.opacity(0.8)
    }
    
    @ViewBuilder
    private func mainView() -> some View {
        VStack(alignment: .center) {
            header()
                .padding([.horizontal, .top])
            
            tabItemRow()
            
            router()
                .padding(.top, 5)
                .padding(.horizontal)
        }
        .frame(size: Config.menubarSize)
    }
    
    @ViewBuilder
    private func header() -> some View {
        HStack {
            Button(width: 23, height: 23) {
                if page == -1 {
                    page = lastPage
                    return
                }
                page = -1
            } content: {
                Image(systemName: "info.circle.fill")
                    .font(.title3)
                    .foregroundColor(page == -1 ? .accentColor : .primary50)
            }
            
            Block(width: 1, height: 1)
            
            Spacer()
            sloganBlock()
            Spacer()
            
            
            TextField(text: $textField) {}
                .frame(width:1, height: 1)
                .opacity(0)
                .focused($focus)
            
            Button(width: 23, height: 23) {
                if page == -2 {
                    page = lastPage
                    return
                }
                page = -2
            } content: {
                Image(systemName: "gearshape.fill")
                    .font(.title3)
                    .foregroundColor(page == -2 ? .accentColor : .primary50)
            }
        }
        .foregroundColor(.dark)
        .monospacedDigit()
    }
    
    
    @ViewBuilder
    private func router() -> some View {
        switch page {
        case -2:
            Setting()
        case -1:
            Info()
        case 0:
            Monitor()
        case 1:
            Deployment()
        case 2:
            Connecting()
        case 3:
            Other()
        case 4:
            CustomButton()
        case 5:
            Dev()
        default:
            Deployment()
        }
    }
    
    @ViewBuilder
    private func sloganBlock() -> some View {
        Button(width: 150, height: 23) {
            container.interactor.copyTimestamp()
        } content: {
            Text("有些事明天再做就好")
                .foregroundColor(.primary50)
        }
    }
    
    @ViewBuilder
    private func tabItemRow() -> some View {
        let height: CGFloat = 35
        let tabs: [String] = ["監控", "部署", "資料庫", "其他", "自訂", "開發"]
        let w: CGFloat = 350 / CGFloat(tabs.count)
        
        HStack(spacing: 0) {
            ForEach(tabs.indices, id: \.self) { i in
                #if DEBUG
                tab(name: tabs[i], tag: i, width: w, height: height)
                #else
                if i <= 4 {
                    tab(name: tabs[i], tag: i, width: w, height: height)
                }
                #endif
            }
        }
        .background(Color.stone)
        .clipShape(RoundedRectangle(cornerRadius: 5))
    }
    
    @ViewBuilder
    private func tab(name: String, tag: Int, width: CGFloat, height: CGFloat) -> some View {
        Button {
            page = tag
            lastPage = tag
        } label: {
            tabBase(tag)
                .frame(width: width, height: height)
                .overlay {
                    Text(name)
                        .font(.title3)
                        .foregroundColor(page == tag ? .white : .primary)
                }
        }
        .buttonStyle(.plain)
        .onHover {
            handleQuickSwitch($0, tag)
        }
    }
    
    @ViewBuilder
    private func tabBase(_ tag: Int) -> some View {
        if page == tag {
            LinearGradient(colors: [.blue, .glue], startPoint: .topLeading, endPoint: .trailing)
        } else {
            Rectangle()
                .foregroundColor(.background)
        }
    }
    
    @ViewBuilder
    private func textPopup() -> some View {
        VStack {
            Spacer()
            if showPopup {
                Text(popupText)
                    .kerning(1)
                    .font(.caption)
                    .foregroundColor(.primary50)
                    .padding(.bottom, 1)
            }
        }
    }
    
    @ViewBuilder
    private func drawPopupPanel(_ popupPanelOption: PopupPanelOption?) -> some View {
        switch popupPanelOption {
            case .createButton:
                ButtonPanel()
            case let .editButton(buttonID: bID):
                ButtonPanel(inputID: bID)
            case let .deleteButton(buttonID: bID):
                popupConfirmPanel("確認要刪除按鈕嗎？", delete: true) {
                    container.interactor.data.deleteUserButton(bID)
                    container.interactor.data.pushUserButtonList()
                }
            case nil:
                EmptyView()
        }
    }
    
    @ViewBuilder
    private func popupConfirmPanel(_ title: String, delete: Bool = false, confirmTitle: String? = nil, confirm: @escaping () -> Void, cancel: @escaping () -> Void = {}) -> some View {
        VStack(spacing: 20) {
            let size = CGSize(width: 100, height: 25)
            Text(title)
                .font(.title3)
            HStack {
                Spacer()
                Button(width: size.width, height: size.height, color: .section, radius: 7) {
                    cancel()
                    self.popupPanelOption = nil
                } content: {
                    Text("取消")
                        .foregroundColor(.gray)
                }
                Spacer()
                Button(width: size.width, height: size.height, color: delete ? .red: .blue, radius: 7) {
                    confirm()
                    self.popupPanelOption = nil
                } content: {
                    Text(confirmTitle ?? (delete ? "刪除" : "確認"))
                        .foregroundColor(.white)
                }
                Spacer()
            }
        }
        .frame(maxWidth: Config.menubarSize.width * 0.8)
        .padding(.vertical, 20)
        .background(Color.background)
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}

// MARK: Function
extension ContentView {
    private func handleQuickSwitch(_ hovered: Bool, _ tag: Int) {
        if page < 0 || !hovered || !quickSwitch { return }
        page = tag
    }
    
    private func handleAppearAction() {
        handleInit()
    }
    
    private func handleInit() {
        if isInit { return }
        isInit = true
        quickSwitch = container.interactor.preference.getQuickSwitch()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .frame(size: Config.menubarSize)
    }
}
