//
//  Bito.swift
//  Bito Pro Secret
//
//  Created by YanunYang on 2022/7/13.
//

import SwiftUI
import Ditto

enum FocusField: Hashable {
    case date, unix, cron
}

struct Other: View {
    private let block: CGFloat = 10
    private let textFieldHeight: CGFloat = 25
    @FocusState var focus: FocusField?
    
    // MARK: Date Transfer
    private static let dateFormat: String = "yyyy-MM-dd HH:mm:ss"
    @State var dateInput: String = Date.now.string(Self.dateFormat)
    @State var unixInput: String = Date.now.unix.description
    
    @State var yearInput: String = Date.now.string("yyyy")
    @State var monthInput: String = Date.now.string("MM")
    @State var dayInput: String = Date.now.string("dd")
    @State var hourInput: String = Date.now.string("HH")
    @State var minuteInput: String = Date.now.string("mm")
    @State var secondInput: String = Date.now.string("ss")
    
    var body: some View {
        scrollView {
            VStack(spacing: 10) {
                section("Backend") {
                    HStack(spacing: 30) {
                        VStack(spacing: 10) {
                            TextLinkBito(name: "Clickup", link: Config.Bito.BackendClickup, image: "hand.thumbsup")
                            TextLinkBito(name: "歡迎光臨", link: Config.Bito.Welcome, image: "video")
                        }
                        VStack(spacing: 10) {
                            TextLinkBito(name: "大機密", link: Config.Bito.ClickupSecret, image: "rectangle.and.pencil.and.ellipsis.rtl")
                            TextLinkBito(name: "大秘寶", link: Config.Bito.ClickupTreasure, image: "shippingbox")
                        }
                    }
                }
                
                section("Bito") {
                    HStack(alignment: .top, spacing: 30) {
                        VStack(spacing: 10) {
                            TextLinkBito(name: "人資系統", link: Config.Bito.HR, image: "calendar")
                            TextLinkBito(name: "BitoLand", link: Config.Bito.BitoLand, image: "house")
                        }
                        VStack(spacing: 10) {
                            TextLinkBito(name: "座位表", link: Config.Bito.Set, image: "chair.lounge")
                            TextLinkBito(name: "分享會", link: Config.Bito.Share, image: "video")
                        }
                    }
                }

    //                section("WiFi") {
    //                    HStack(spacing: 20) {
    //                        ButtonCopy(copy: "PSP-Guest\nGuest@86668968", width: 40)
    //                        VStack {
    //                            Text("訪客 Wifi")
    //                                .frame(width: 180, alignment: .leading)
    //                            Text("帳號：PSP-Guest")
    //                                .frame(width: 180, alignment: .leading)
    //                            Text("密碼：Guest@86668968")
    //                                .frame(width: 180, alignment: .leading)
    //                        }
    //                        .multilineTextAlignment(.leading)
    //                    }
    //                }
                section("時間轉換工具", font: .body, dateTransfer)
                
                Spacer()
            }
        }
//        .onAppear { focus = .unix }
    }
    
    @ViewBuilder
    private func dateTransfer() -> some View {
        HStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    HStack(spacing: 10) {
                        let symbolColor: Color = .primary.opacity(0.8)
                        HStack(spacing: 2)  {
                            dateTextField($yearInput, digit: 4, max: 9999)
                            Text("-").foregroundColor(symbolColor)
                            dateTextField($monthInput, max: 12)
                            Text("-").foregroundColor(symbolColor)
                            dateTextField($dayInput, max: 31)
                        }
                        HStack(spacing: 2) {
                            dateTextField($hourInput, max: 24)
                            Text(":").foregroundColor(symbolColor)
                            dateTextField($minuteInput)
                            Text(":").foregroundColor(symbolColor)
                            dateTextField($secondInput)
                        }
                    }
//                    ButtonCopy(name: "複製時間", copy: dateInput, width: 80, height: 25)
                }
                .frame(height: 35, alignment: .leading)
                
                HStack {
//                    ButtonPaste(name: "貼上",paste: $unixInput, width: 60, height: 25, image: "arrow.right", preAction: {
//                        focus = .unix
//                    }, postAction: {
//                        unix2Date()
//                    })
                    TextField("unix", text: $unixInput)
                        .focused($focus, equals: .unix)
                        .frame(height: textFieldHeight)
                        .padding(.horizontal, 10)
                        .background(Color.background2, ignoresSafeAreaEdges: [])
                        .cornerRadius(7)
//                    ButtonCopy(name: "複製unix", copy: unixInput, width: 80, height: 25)
                    
                    Button(width: 60, height: 25, colors: [.blue, .glue], radius: 7) {
                        unixInput = Date.now.unix.description
                        unix2Date()
                    } content: {
                        Text("Now")
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                    }
                    .shadow(radius: 1)
                }
                .frame(width: 219, height: 35)
            }
            .textFieldStyle(.plain)
        }
        .onChange(of: yearInput) { _ in handleDate2Unix() }
        .onChange(of: monthInput) { _ in handleDate2Unix() }
        .onChange(of: dayInput) { _ in handleDate2Unix() }
        .onChange(of: hourInput) { _ in handleDate2Unix() }
        .onChange(of: minuteInput) { _ in handleDate2Unix() }
        .onChange(of: secondInput) { _ in handleDate2Unix() }
        .onChange(of: unixInput) { _ in handleUnix2Date() }
    }
    
    @ViewBuilder
    private func dateTextField(_ text: Binding<String>, digit: Int = 2, max: Int = 60) -> some View {
        TextField("", text: limitation(text, limit: digit, max: max))
            .focused($focus, equals: .date)
            .frame(width: CGFloat(digit*8), height: textFieldHeight, alignment: .center)
            .padding(.horizontal, 5)
            .background(Color.background2, ignoresSafeAreaEdges: [])
            .cornerRadius(7)
    }
}

struct Bito_Previews: PreviewProvider {
    static var previews: some View {
        Other()
            .frame(size: Config.menubarSize)
    }
}

extension Other {
    func limitation(_ text: Binding<String>, limit: Int, max: Int) -> Binding<String> {
        return Binding {
            return text.wrappedValue
        } set: { value in
            if value.count > limit {
                text.wrappedValue = max.description
                return
            }
            if value.count != 0 {
                guard let int = Int(value) else {
                    let temp = text.wrappedValue
                    text.wrappedValue = temp
                    return
                }
                if int > max {
                    text.wrappedValue = max.description
                    return
                }
            }
            text.wrappedValue = value
        }

    }
    
    func handleDate2Unix() {
        if focus == .unix { return }
        #if DEBUG
        print("date invoke - \(Date.now.unix)")
        #endif
        date2Unix()
    }
    
    func date2Unix() {
        dateInput = "\(yearInput)-\(monthInput)-\(dayInput) \(hourInput):\(minuteInput):\(secondInput)"
        guard let date = Date(from: dateInput, Self.dateFormat, .us, .current) else {
            unixInput = "?"
            return
        }
        unixInput = date.unix.description
    }
    
    func handleUnix2Date() {
        if focus != .unix { return }
        #if DEBUG
        print("unix invoke - \(Date.now.unix)")
        #endif
        unix2Date()
    }
    
    func unix2Date() {
        guard let unix = Int(unixInput) else {
            yearInput = ""
            monthInput = ""
            dayInput = ""
            hourInput = ""
            minuteInput = ""
            secondInput = ""
            return
        }
        let d = Date.init(timeIntervalSince1970: 0).addingTimeInterval(.init(unix))
        dateInput = d.string(Self.dateFormat, .us, .current)
        yearInput = d.string("yyyy")
        monthInput = d.string("MM")
        dayInput = d.string("dd")
        hourInput = d.string("HH")
        minuteInput = d.string("mm")
        secondInput = d.string("ss")
    }
}

extension Other {
    func TextLinkBito(name: String, link: String, image: String? = nil) -> some View {
        TextLink(name: name, link: link, width: 70, image: image) {
            focus = nil
        }
    }
}
