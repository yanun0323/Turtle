import SwiftUI

struct LoadingView: View {
    @Environment(\.openURL) private var openURL
    @State var countdown: Int = 3
    @State var timer: Timer? = nil
    @State var title: String
    @State var shotdown: Bool
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                ZStack {
                    LoadingCircle(color: .gray, size: 50, lineWidth: 2, speed: 1.2)
                    if timer != nil {
                        Text(countdown.description)
                            .font(.title)
                    }
                }
                Text(title)
                    .foregroundColor(.primary50)
                    .font(.body)
                Spacer()
            }
            Spacer()
        }
        .background(Color.background2.opacity(0.8))
        .onAppear {
            if !shotdown { return }
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { t in
                countdown -= 1
                if countdown == 0 {
                    t.invalidate()
                }
            })
        }
        .onChange(of: countdown) { _ in
            if countdown <= 0 {
                openURL(URL(string: VersionManager.fileUrl)!)
                NSApplication.shared.terminate(self)
                
            }
        }
    }
    
}

struct DownloadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(title: "下載更新並關閉小烏龜...", shotdown: false)
    }
}

struct LoadingCircle: View {
    @State private var isLoading = false
    let color: Color
    let size: CGFloat
    let lineWidth: CGFloat
    let speed: Double
    var body: some View {
        Circle()
            .trim(from: 0, to: 0.65)
            .stroke(color, style: StrokeStyle(lineWidth: lineWidth))
            .frame(width: size, height: size)
            .rotationEffect(Angle(degrees:isLoading ? 360 : 0))
            .animation(.linear(duration: speed).repeatForever(autoreverses: false), value: isLoading)
            .onAppear {
                isLoading = true
            }
            .transition(.opacity)
    }
}
