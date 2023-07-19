//
//  Bito_Pro_SecretApp.swift
//  Bito Pro Secret
//
//  Created by YanunYang on 2022/7/12.
//

import SwiftUI
import Ditto

@main
struct Bito_Pro_SecretApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @Environment(\.scenePhase) var scenePhase
    private var container = DIContainer(isMock: false)
    
    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}


class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject {
    
    public var statusItem: NSStatusItem?
    private var popOver = NSPopover()
    private var container = DIContainer(isMock: false)
    private var isAppOpen = false
    
    @MainActor func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.appearance = container.interactor.preference.getAppearance()
        
        popOver.setValue(true, forKeyPath: "shouldHideAnchor")
        popOver.contentSize = Config.menubarSize
        popOver.behavior = .transient
        popOver.animates = true
        popOver.contentViewController = NSViewController()
        popOver.contentViewController = NSHostingController(rootView: ContentView()
            .textEditerCommand()
            .environment(\.injected, container)
            .environment(\.popOver, popOver)
            .hotkey(key: .kVK_ANSI_S, keyBase: [KeyBase.command, .option], action: {
                self.togglePopover()
            })
        )
        
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        
        _ = container.appstate.pubOpenMenubarAppTrigger.sink { self.isAppOpen = $0 }
          
        if let statusButton = statusItem?.button {
            #if DEBUG
            statusButton.image = NSImage(systemSymbolName: "tortoise.fill", accessibilityDescription: nil)
            #else
            statusButton.image = NSImage(systemSymbolName: "tortoise", accessibilityDescription: nil)
            #endif
            statusButton.action = #selector(togglePopover)
        }
    }
    
    @objc public func togglePopover() {
        if let button = statusItem?.button {
            self.container.interactor.system.pushOpenMenubarAppTrigger(self.isAppOpen)
            Updater.checkForUpdateSchedule()
            self.popOver.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.maxY)
        }
        
    }
}

extension NSPopover: EnvironmentKey {
    public static var defaultValue: NSPopover { NSPopover() }
}

extension EnvironmentValues {
    public var popOver: NSPopover {
        get { self[NSPopover.self] }
        set { self[NSPopover.self] = newValue }
    }
}


fileprivate struct KeyboardEventModifier: ViewModifier {
    enum Key: String {
        case a, c, v, x
    }
    
    let key: Key
    let modifiers: EventModifiers
    
    func body(content: Content) -> some View {
        content.keyboardShortcut(KeyEquivalent(Character(key.rawValue)), modifiers: modifiers)
    }
}

extension View {
    fileprivate func keyboardShortcut(_ key: KeyboardEventModifier.Key, modifiers: EventModifiers = .command) -> some View {
        modifier(KeyboardEventModifier(key: key, modifiers: modifiers))
    }
}

extension View {
    func textEditerCommand() -> some View {
        self
            .hotkey(key: .kVK_ANSI_A, keyBase: [KeyBase.command]) {
                NSApp.sendAction(#selector(NSText.selectAll(_:)), to: nil, from: nil)
            }
            .hotkey(key: .kVK_ANSI_C, keyBase: [KeyBase.command]) {
                NSApp.sendAction(#selector(NSText.copy(_:)), to: nil, from: nil)
            }
            .hotkey(key: .kVK_ANSI_X, keyBase: [KeyBase.command]) {
                NSApp.sendAction(#selector(NSText.cut(_:)), to: nil, from: nil)
            }
            .hotkey(key: .kVK_ANSI_V, keyBase: [KeyBase.command]) {
                NSApp.sendAction(#selector(NSText.paste(_:)), to: nil, from: nil)
            }
            .hotkey(key: .kVK_ANSI_Z, keyBase: [KeyBase.command]) {
                NSApp.sendAction(Selector(("undo:")), to: nil, from: nil)
            }
            .hotkey(key: .kVK_ANSI_Z, keyBase: [KeyBase.shift, KeyBase.command]) {
                NSApp.sendAction(Selector(("redo:")), to:nil, from:self)
            }
    }
}
