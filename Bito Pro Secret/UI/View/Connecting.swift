import SwiftUI
import Ditto

// MARK: Main
struct Connecting: View {
    private let block: CGFloat = 10
    private let rowWidth: CGFloat = 300

    var body: some View {
        scrollView {
            VStack(spacing: 10) {
                block("MySQL", [
                    CopySets("Staging", [
                        Config.MySQL.Staging.Host,
                        Config.MySQL.Staging.User,
                        Config.MySQL.Staging.Password,
                        Config.MySQL.Staging.Database,
                    ]),
                    CopySets("Demo", [
                        Config.MySQL.Demo.Host,
                        Config.MySQL.Demo.User,
                        Config.MySQL.Demo.Password,
                        Config.MySQL.Demo.Database,
                    ]),
                    CopySets("Hotfix", [
                        Config.MySQL.Hotfix.Host,
                        Config.MySQL.Hotfix.User,
                        Config.MySQL.Hotfix.Password,
                        Config.MySQL.Hotfix.Database,
                    ]),
                    CopySets("ExStaging", [
                        Config.MySQL.ExStaging.Host,
                        Config.MySQL.ExStaging.User,
                        Config.MySQL.ExStaging.Password,
                        Config.MySQL.ExStaging.Database,
                    ])
                ])
                
                block("Mongo", [
                    CopySets("Staging", [
                        Config.Mongo.Staging.Host,
                        Config.Mongo.Staging.User,
                        Config.Mongo.Staging.Password,
                        Config.Mongo.Staging.Database,
                    ]),
                    CopySets("ExStaging", [
                        Config.Mongo.ExStaging.Host,
                        Config.Mongo.ExStaging.User,
                        Config.Mongo.ExStaging.Password,
                        Config.Mongo.ExStaging.Database,
                    ])
                ])
                
                block("Redis", [
                    CopySets("Staging", [Config.Redis.Staging]),
                    CopySets("Demo", [Config.Redis.Demo]),
                    CopySets("Hotfix", [Config.Redis.Hotfix]),
                    CopySets("Ex-Staging", [Config.Redis.ExStaging]),
                    CopySets("Ex-Demo", [Config.Redis.ExDemo]),
                    CopySets("Ex-Hotfix", [Config.Redis.ExHotfix]),
                ], isRedis: true)
                
                Spacer()
            }
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

struct Connection_Previews: PreviewProvider {
    static var previews: some View {
        Connecting()
            .frame(size: Config.menubarSize)
    }
}


