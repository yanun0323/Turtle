import SwiftUI
import Combine

struct AppState {
    private static var `default`: AppState? = nil
    
    public let pubAccenctColor = PassthroughSubject<Color, Never>()
    public let pubUserButtonStore = CurrentValueSubject<[UserButton], Never>([])
    public let pubPopupText = PassthroughSubject<String?, Never>()
    public let pubOpenMenubarAppTrigger = PassthroughSubject<Bool, Never>()
    public let pubFocus = PassthroughSubject<Bool, Never>()
    public let pubQuickSwitch = PassthroughSubject<Bool, Never>()
    
    public let pubPopupPanelOption = PassthroughSubject<PopupPanelOption?, Never>()
    public let scheme = PassthroughSubject<ColorScheme?, Never>()
    public let secret = CurrentValueSubject<Secret?, Never>(nil)
}

extension AppState {
    public static func get() -> Self {
        if Self.default.isNil {
            Self.default = Self()
        }
        return Self.default!
    }
}

enum PopupPanelOption {
    case createButton
    case editButton(buttonID: Int64)
    case deleteButton(buttonID: Int64)
}
