import SwiftUI
import Ditto

struct WhatsNewView: View {
    @Environment(\.injected) private var container
    @Environment(\.presentationMode) private var presentationMode
    @State private var versionFile: FileInfo?
    
    var body: some View {
        VStack {
            Text("What's New")
            HStack {
                Button(width: 200, height: 30, colors: [.blue, .glue]) {
                    dismiss()
                } content: {
                    Text("Dismiss")
                }
                Spacer()
                Button(width: 200, height: 30, colors: [.blue, .glue]) {
                    dismiss()
                } content: {
                    Text("Download and Relauch")
                }
            }
        }
    }
}

fileprivate extension WhatsNewView {
    private func dismiss() {
        for window in NSApplication.shared.windows {
            print(window.identifier?.rawValue ?? "-")
            guard let id = window.identifier?.rawValue else { continue }
            if id == "whats-new" {
                window.close()
            }
        }
    }
}

struct WhatsNewView_Previews: PreviewProvider {
    static var previews: some View {
        WhatsNewView()
            .inject(.default)
    }
}
