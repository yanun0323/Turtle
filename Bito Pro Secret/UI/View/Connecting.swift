import SwiftUI
import Ditto

// MARK: Main
struct Connecting: View {
    @Environment(\.injected) private var container
    private let block: CGFloat = 10
    private let rowWidth: CGFloat = 300
    @State private var database: Secret.Bito.Database = Secret.default.bito.database

    var body: some View {
        scrollView {
            VStack(spacing: 10) {
                block("MySQL", [
                    CopySets("Staging", [
                        database.mysql.staging.host,
                        database.mysql.staging.username,
                        database.mysql.staging.password,
                        database.mysql.staging.database,
                    ]),
                    CopySets("Demo", [
                        database.mysql.demo.host,
                        database.mysql.demo.username,
                        database.mysql.demo.password,
                        database.mysql.demo.database,
                    ]),
                    CopySets("Hotfix", [
                        database.mysql.hotfix.host,
                        database.mysql.hotfix.username,
                        database.mysql.hotfix.password,
                        database.mysql.hotfix.database,
                    ]),
                ])
                
                block("Mongo", [
                    CopySets("Staging", [
                        database.mongo.staging.host,
                        database.mongo.staging.username,
                        database.mongo.staging.password,
                        database.mongo.staging.database,
                    ]),
                ])
                
                block("Redis", [
                    CopySets("Staging", [database.redis.staging]),
                    CopySets("Demo", [database.redis.demo]),
                    CopySets("Hotfix", [database.redis.hotfix]),
                ], isRedis: true)
                
                Spacer()
            }
        }
        .onReceive(container.appstate.secret) {
            guard let sec = $0 else { return }
            database = sec.bito.database
        }
    }
    
    @ViewBuilder
    private func block(_ title: String, _ set: [CopySets], isRedis: Bool = false) -> some View {
        section(title) {
            if isRedis {
                sectionRowsRedisContent(set)
            } else {
                sectionRowsContent(set)
            }
        }
    }
    
    @ViewBuilder
    private func sectionRowsContent(_ set: [CopySets]) -> some View {
        ForEach(set, id: \.self) { set in
            sectionRowButtons(set)
        }
    }
    
    @ViewBuilder
    private func sectionRowsRedisContent(_ set: [CopySets]) -> some View {
        let leftIndexEnd = (set.count-1)/2
        let redisGap: CGFloat = 20
        HStack(spacing: redisGap) {
            VStack {
                ForEach(0...leftIndexEnd, id: \.self) { i in
                    sectionRowButtons(set[i], isRedis: true, redisGap: redisGap/2)
                }
            }
            VStack {
                ForEach(leftIndexEnd+1..<set.count, id: \.self) { i in
                    sectionRowButtons(set[i], isRedis: true, redisGap: redisGap/2)
                }
            }
        }
    }
    
    @ViewBuilder
    private func sectionRowButtons(_ set: CopySets, isRedis: Bool = false, redisGap: CGFloat = 0) -> some View {
        let gap: CGFloat = 5
        let labelWidth: CGFloat = 80
        let rowWidthFixed: CGFloat = isRedis ? rowWidth/2 : rowWidth
        HStack(spacing: gap) {
            Text(set.title)
                .font(.system(size: 16, weight: .regular, design: .rounded))
                .frame(width: labelWidth, alignment: .leading)
            let count = CGFloat(set.texts.count)
            let width = (rowWidthFixed - labelWidth - (gap * (count - 1)) - redisGap) / count
            ForEach(set.texts.indices, id: \.self) { i in
                ButtonCopy(name: getLabel(i), copy: set.texts[i], width: width)
            }
        }
    }
    
}

// MARK: Function
extension Connecting {
    func getLabel(_ i: Int) -> String {
        switch i {
        case 0:
            return "Host"
        case 1:
            return "帳號"
        case 2:
            return "密碼"
        case 3:
            return "DB"
        default:
            return ""
        }
    }
}

#Preview {
    Connecting()
        .frame(size: Config.menubarSize)
        .padding()
        .inject(.default)
}

