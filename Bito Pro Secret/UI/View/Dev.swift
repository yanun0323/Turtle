import SwiftUI
import Ditto
import Foundation



struct Dev: View {
    @FocusState var focus: FocusField?
    
    // MARK: Cron Transfer
    @State var cronInput: String = "* * * * * *"
    @State var cronExpression: String = ""
    let cronDefault: String = "* * * * * *"
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            section("Cron Expression(開發中)", font: .body, cronTransfer )
                .disabled(true)
            Spacer()
        }
//        .onAppear { focus = .date }
    }
    
   
    
    @ViewBuilder
    private func cronTransfer() -> some View {
        let textFieldHeight: CGFloat = 25
        VStack {
            TextField("* * * * * *", text: $cronInput)
                .focused($focus, equals: .cron)
                .multilineTextAlignment(.center)
                .font(.system(.title, design: .rounded))
                .monospacedDigit()
                .frame(height: textFieldHeight)
                .padding(.horizontal, 5)
                .background(Color.background2, ignoresSafeAreaEdges: [])
                .cornerRadius(7)
                .textFieldStyle(.plain)
            Text(cronExpression)
        }
        .onChange(of: cronInput) { _ in handleCron2Expression() }
    }
    
}

extension Dev {
    
    
    
    func handleCron2Expression() {
        if focus != .cron { return }
        let slice = cronInput.split(whereSeparator: { $0 == " " })
        if slice.count != 6 {
            cronExpression = "-"
            return
        }
        
//        let second = handleSecondExpression(slice[0])
//        let minute = handleMinuteExpression(slice[1])
//        let hour = handleHourExpression(slice[2])
//        let dayOfMonth = handleDayOfMonthExpression(slice[3])
//        let month = handleMonthExpression(slice[4])
//        let weekOfMonth = handleDayOfWeekExpression(slice[5])
    }
    
    func handleSecondExpression(_ s: String.SubSequence) -> String {
        if s.count == 1 {
            switch s {
            case "*":
                return "每秒"
            default:
                return ""
            }
        }
        return ""
    }
    
    func handleMinuteExpression(_ s: String.SubSequence) -> String {
        return ""
    }
    
    func handleHourExpression(_ s: String.SubSequence) -> String {
        return ""
    }
    
    func handleDayOfMonthExpression(_ s: String.SubSequence) -> String {
        return ""
    }
    
    func handleMonthExpression(_ s: String.SubSequence) -> String {
        return ""
    }
    
    func handleDayOfWeekExpression(_ s: String.SubSequence) -> String {
        return ""
    }
}

#if Debug
struct ToolView_Previews: PreviewProvider {
    static var previews: some View {
        Dev()
            .frame(size: Config.menubarSize)
    }
}
#endif
