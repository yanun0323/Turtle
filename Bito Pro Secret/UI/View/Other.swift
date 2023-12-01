//
//  Bito.swift
//  Bito Pro Secret
//
//  Created by YanunYang on 2022/7/13.
//

import SwiftUI
import Ditto
import BigInt

enum FocusField: Hashable {
    case date, string, unix, cron, emIDEncode, emIDDecode, imIDEncode, imIDDecode, orderIDEncode, orderIDDecode, orderTypeDecode
}

struct Other: View {
    @Environment(\.injected) private var container
    @Environment(\.openURL) private var openURL
    @FocusState private var focus: FocusField?
    private let block: CGFloat = 10
    private let textFieldHeight: CGFloat = 25
    
    // MARK: Date Transfer
    private static let stringInputFormat = "yyyy-MM-dd HH:mm:ss ZZ"
    private static let tempDateFormat: String = "yyyy-MM-dd HH:mm:ss"
    @State private var stringInput: String = Date.now.string(Self.stringInputFormat)
    @State private var unixInput: String = Date.now.unix.description
    
    @State private var yearInput: String = Date.now.string("yyyy")
    @State private var monthInput: String = Date.now.string("MM")
    @State private var dayInput: String = Date.now.string("dd")
    @State private var hourInput: String = Date.now.string("HH")
    @State private var minuteInput: String = Date.now.string("mm")
    @State private var secondInput: String = Date.now.string("ss")
    @State private var other: Secret.Bito.Other = Secret.default.bito.other
    
    @State private var userEmIDEncoded = ""
    @State private var userEmIDDecoded = ""
    @State private var userImIDEncoded = ""
    @State private var userImIDDecoded = ""
    @State private var orderIDEncoded = ""
    @State private var orderTypeDecoded = ""
    @State private var orderIDDecoded = ""
    
    var body: some View {
        scrollView {
            VStack(spacing: 10) {
                section("Backend") {
                    HStack(spacing: 30) {
                        TextLinkBito(name: "大機密", link: other.backendBigSecret, image: "rectangle.and.pencil.and.ellipsis.rtl")
                        TextLinkBito(name: "大秘寶", link: other.backendBigTresure, image: "shippingbox")
                    }
                }
                
                section("Bito") {
                    HStack(alignment: .top, spacing: 30) {
                        VStack(spacing: 10) {
                            TextLinkBito(name: "人資系統", link: other.hr, image: "calendar")
                            TextLinkBito(name: "BitoLand", link: other.bitoLand, image: "house")
                        }
                        VStack(spacing: 10) {
                            TextLinkBito(name: "座位表", link: other.seat, image: "chair.lounge")
                            TextLinkBito(name: "分享會", link: other.shareMeeting, image: "video")
                        }
                    }
                }
                
                section("時間轉換工具", font: .body, dateTransfer)
                
                section("ID 加解密工具", font: .body, idCoder)
                
                section("Mermaid", mermaidBlock)
                
                Spacer()
            }
        }
        .onReceive(container.appstate.secret) {
            guard let sec = $0 else { return }
            other = sec.bito.other
        }
        .hotkey(key: .kVK_Return) {
            handleDate2All()
            handleUnix2All()
            handleString2All()
        }
    }

    @ViewBuilder
    func textField(_ titleKey: LocalizedStringKey, text: Binding<String>) -> some View {
        TextField(titleKey, text: text)
            .frame(height: textFieldHeight)
            .padding(.horizontal, 7)
            .background(Color.background2, ignoresSafeAreaEdges: [])
            .cornerRadius(7)
    }
    
    @ViewBuilder
    private func idCoder() -> some View {
        HStack {
            VStack {
                Text("UserEm")
                    .frame(height: textFieldHeight)
                Text("UserIm")
                    .frame(height: textFieldHeight)
                Text("Order")
                    .frame(height: textFieldHeight)
            }
            .foregroundStyle(.primary.opacity(0.8))
            .fontDesign(.rounded)
            .frame(width: 50)
            
            VStack {
                textField("5908476992", text: $userEmIDEncoded)
                    .focused($focus, equals: .emIDEncode)
                textField("3687091180", text: $userImIDEncoded)
                    .focused($focus, equals: .imIDEncode)
                textField("SL-2170878897", text: $orderIDEncoded)
                    .focused($focus, equals: .orderIDEncode)
            }
            
            VStack {
                Image(systemName: "arrow.left.arrow.right")
                    .frame(height: textFieldHeight)
                Image(systemName: "arrow.left.arrow.right")
                    .frame(height: textFieldHeight)
                Image(systemName: "arrow.left.arrow.right")
                    .frame(height: textFieldHeight)
            }
            .foregroundStyle(.gray)
            
            VStack {
                textField("11", text: $userEmIDDecoded)
                    .focused($focus, equals: .emIDDecode)
                textField("25", text: $userImIDDecoded)
                    .focused($focus, equals: .imIDDecode)
                HStack(spacing: 5) {
                    textField("SL", text: $orderTypeDecoded)
                        .focused($focus, equals: .orderTypeDecode)
                        .frame(width: 40, alignment: .center)
                        .multilineTextAlignment(.center)
                    textField("18051", text: $orderIDDecoded)
                        .focused($focus, equals: .orderIDDecode)
                }
            }
            .frame(width: 145)
        }
        .textFieldStyle(.plain)
        .padding(.horizontal, 5)
        .monospacedDigit()
        .onChange(of: userEmIDDecoded) { _ in handleEncodeEmID() }
        .onChange(of: userEmIDEncoded) { _ in handleDecodeEmID() }
        .onChange(of: userImIDDecoded) { _ in handleEncodeImID() }
        .onChange(of: userImIDEncoded) { _ in handleDecodeImID() }
        .onChange(of: orderIDDecoded) { _ in handleEncodeOrderID() }
        .onChange(of: orderTypeDecoded) { _ in handleEncodeOrderID() }
        .onChange(of: orderIDEncoded) { _ in handleDecodeOrderID() }
    }
    
    @ViewBuilder
    private func dateTransfer() -> some View {
        HStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    HStack(spacing: 10) {
                        let symbolColor: Color = .primary.opacity(0.8)
                        HStack(spacing: 2)  {
                            dateTextField($yearInput, "2023", digit: 4, max: 9999)
                            Text("-").foregroundColor(symbolColor)
                            dateTextField($monthInput, "03", max: 12)
                            Text("-").foregroundColor(symbolColor)
                            dateTextField($dayInput, "23", max: 31)
                        }
                        HStack(spacing: 2) {
                            dateTextField($hourInput, "09", max: 24)
                            Text(":").foregroundColor(symbolColor)
                            dateTextField($minuteInput, "23")
                            Text(":").foregroundColor(symbolColor)
                            dateTextField($secondInput, "30")
                        }
                    }
                }
                .frame(height: 35, alignment: .leading)
                
                HStack {
                    textField("1679534610", text: $unixInput)
                        .focused($focus, equals: .unix)
                    
                    Button(width: 60, height: 25, colors: [.blue, .glue], radius: 7) {
                        unixInput = Date.now.unix.description
                        unix2All()
                    } content: {
                        Text("Now")
                            .font(.system(size: 12))
                            .foregroundColor(.white)
                    }
                    .shadow(radius: 1)
                }
                .frame(width: 219, height: 35)
                
                
                HStack {
                    textField("2023-03-23 09:23:30 +0800", text: $stringInput)
                        .focused($focus, equals: .string)
                }
                .frame(width: 219, height: 35)
                
            }
            .textFieldStyle(.plain)
        }
        .onChange(of: yearInput) { _ in handleDate2All() }
        .onChange(of: monthInput) { _ in handleDate2All() }
        .onChange(of: dayInput) { _ in handleDate2All() }
        .onChange(of: hourInput) { _ in handleDate2All() }
        .onChange(of: minuteInput) { _ in handleDate2All() }
        .onChange(of: secondInput) { _ in handleDate2All() }
        .onChange(of: unixInput) { _ in handleUnix2All() }
        .onChange(of: stringInput) { _ in handleString2All() }
    }
    
    @ViewBuilder
    private func dateTextField(_ text: Binding<String>, _ title: String, digit: Int = 2, max: Int = 60) -> some View {
        TextField(title, text: limitation(text, limit: digit, max: max))
            .focused($focus, equals: .date)
            .frame(width: CGFloat(digit*8), height: textFieldHeight, alignment: .center)
            .padding(.horizontal, 5)
            .background(Color.background2, ignoresSafeAreaEdges: [])
            .cornerRadius(7)
    }
    
    @ViewBuilder
    private func mermaidBlock() -> some View {
        HStack(spacing: 30) {
            Button(width: 100, height: .buttonHeight, colors: Color.main, radius: .buttonRadius) {
                guard let url = URL(string: "https://mermaid-js.github.io/mermaid-live-editor/") else { return }
                openURL(url)
            } content: {
                Text("Mermaid")
                    .foregroundColor(.white)
            }
            .shadow(radius: .shadow)
            
            Button(width: 180, height: .buttonHeight, color: .background, radius: .buttonRadius) {
                HandleMermaidMarkdown()
            } content: {
                Text("替換拷貝的 Mermaid 背景")
                    .foregroundColor(.primary)
                
            }
            .shadow(radius: .shadow)
        }

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
    
    func handleDate2All() {
        if focus != .date { return }
        #if DEBUG
        print("date invoke - \(Date.now.unix)")
        #endif
        date2All()
    }
    
    func date2All() {
        let temp = "\(yearInput)-\(monthInput)-\(dayInput) \(hourInput):\(minuteInput):\(secondInput)"
        guard let date = Date(from: temp, Self.tempDateFormat, .us, .current) else {
            unixInput = ""
            stringInput = ""
            return
        }
        unixInput = date.unix.description
        stringInput = date.string(Self.stringInputFormat, .us)
    }
    
    func handleString2All() {
        if focus != .string { return }
        #if DEBUG
        print("string invoke - \(Date.now.unix)")
        #endif
        string2All()
    }
    
    func string2All() {
        guard let d = Date(from: stringInput, Self.stringInputFormat, .us, .current) else {
            unixInput = ""
            yearInput = ""
            monthInput = ""
            dayInput = ""
            hourInput = ""
            minuteInput = ""
            secondInput = ""
            return
        }
        
        unixInput = d.unix.description
        yearInput = d.string("yyyy")
        monthInput = d.string("MM")
        dayInput = d.string("dd")
        hourInput = d.string("HH")
        minuteInput = d.string("mm")
        secondInput = d.string("ss")
    }
    
    func handleUnix2All() {
        if focus != .unix { return }
        #if DEBUG
        print("unix invoke - \(Date.now.unix)")
        #endif
        unix2All()
    }
    
    func unix2All() {
        guard let unix = Int(unixInput) else {
            yearInput = ""
            monthInput = ""
            dayInput = ""
            hourInput = ""
            minuteInput = ""
            secondInput = ""
            stringInput = ""
            return
        }
        let d = Date.init(timeIntervalSince1970: 0).addingTimeInterval(.init(unix))
        stringInput = d.string(Self.stringInputFormat, .us, .current)
        yearInput = d.string("yyyy")
        monthInput = d.string("MM")
        dayInput = d.string("dd")
        hourInput = d.string("HH")
        minuteInput = d.string("mm")
        secondInput = d.string("ss")
    }
    
    func HandleMermaidMarkdown() {
        guard let read = NSPasteboard.general.string(forType: .string) else { return }
        let replaced = read.replacingOccurrences(of: "type=png", with: "type=jpg")
        container.interactor.copy(replaced)
    }
}

extension Other {
    func TextLinkBito(name: String, link: String, image: String? = nil) -> some View {
        TextLink(name: name, link: link, width: 70, image: image) {
            focus = nil
        }
    }
}

// MARK: - EmID
extension Other {
    func handleEncodeEmID() {
        if focus != .emIDDecode { return }
        if userEmIDDecoded.isEmpty {
            userEmIDEncoded = ""
            return
        }
        guard let id = BigInt(userEmIDDecoded, radix: 10) else {
            userEmIDEncoded = ""
            return
        }

        userEmIDEncoded = encodeEmID(id).description
    }
    
    func handleDecodeEmID() {
        if focus != .emIDEncode { return }
        if userEmIDEncoded.isEmpty {
            userEmIDDecoded = ""
            return
        }
        guard let id = BigInt(userEmIDEncoded, radix: 10) else {
            userEmIDDecoded = ""
            return
        }

        userEmIDDecoded = decodeEmID(id).description
    }
    
    
    func encodeEmID(_ userID: BigInt) -> BigInt {
        return (userID * BigInt(68718952447))%BigInt(9999999999)
    }
    
    func decodeEmID(_ encodedUserID: BigInt) -> BigInt {
        return ((encodedUserID*BigInt(8394529963))%BigInt(9999999999))
    }
}

// MARK: - ImID
extension Other {
    func handleEncodeImID() {
        if focus != .imIDDecode { return }
        if userImIDDecoded.isEmpty {
            userImIDEncoded = ""
            return
        }
        guard let id = BigInt(userImIDDecoded, radix: 10) else {
            userImIDEncoded = ""
            return
        }

        userImIDEncoded = encodeImID(id).description
    }
    
    func handleDecodeImID() {
        if focus != .imIDEncode { return }
        if userImIDEncoded.isEmpty {
            userImIDDecoded = ""
            return
        }
        guard let id = BigInt(userImIDEncoded, radix: 10) else {
            userImIDDecoded = ""
            return
        }

        userImIDDecoded = decodeImID(id).description
    }
    
    func encodeImID(_ userID: BigInt) -> BigInt {
        return (userID*BigInt(2147483647))%BigInt(9999999999)
    }
    
    func decodeImID(_ encodeUserID: BigInt) -> BigInt {
        return (encodeUserID*BigInt(9253624546)%BigInt(9999999999))
    }
}

// MARK: - OrderID
extension Other {
    func handleEncodeOrderID() {
        if focus != .orderIDDecode { return }
        if orderIDDecoded.isEmpty {
            orderIDEncoded = ""
            return
        }
        
        guard let id = BigInt(orderIDDecoded, radix: 10) else {
            orderIDEncoded = ""
            return
        }

        orderIDEncoded = orderTypeDecoded + "-" + encodeOrderID(id).description
    }
    
    func handleDecodeOrderID() {
        if focus != .orderIDEncode { return }
        if orderIDEncoded.isEmpty {
            orderTypeDecoded = ""
            orderIDDecoded = ""
            return
        }
        
        let spIdx = orderIDEncoded.firstIndex(where: { $0.description == "-" })
        var type = ""
        var idNum = orderIDEncoded
        if let idx = spIdx {
            type = String(idNum.prefix(upTo: idx))
            idNum = String(idNum.suffix(from: idx).dropFirst())
        }
        
        guard let id = BigInt(idNum, radix: 10) else {
            orderTypeDecoded = ""
            orderIDDecoded = ""
            return
        }

        orderTypeDecoded = type
        orderIDDecoded = decodeOrderID(id).description
    }
    
    
    func encodeOrderID(_ userID: BigInt) -> BigInt {
        return (userID * BigInt(274876858367))%BigInt(9999999999)
    }
    
    func decodeOrderID(_ encodedUserID: BigInt) -> BigInt {
        return ((encodedUserID*BigInt(8692771022))%BigInt(9999999999))
    }
}

#Preview {
    Other()
        .frame(size: Config.menubarSize)
        .padding()
        .inject(.default)
}
