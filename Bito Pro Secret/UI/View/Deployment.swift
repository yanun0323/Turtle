//
//  Deployment.swift
//  Bito Pro Secret
//
//  Created by YanunYang on 2022/7/13.
//

import SwiftUI
import Ditto

struct Deployment: View {
    @State var hoverDeployment = false
    @State var hoverConfigmap = false
    @State var hints: [String] = []
    private let block: CGFloat = 10
    private let rowWidth: CGFloat = 330
    
    var body: some View {
        scrollView {
            VStack(alignment: .leading, spacing: 7.5)  {
                section("Jenkins", spacing: 7.5) {
                    hintRow("Deployment", [
                        "Deployment 開發規則",
                        "RC/Prod 改 staging branch 並發 MR 給 SRE",
                        "＊ Staging/Demo/Hotfix 環境吃 staging branch",
                        "＊ RC/Prod 環境吃 master branch",
                    ], [])
                    
                    hintRow("開發", [
                        "部署 Dependency Package",
                        "所有環境都是吃 development branch"
                    ], [
                        LinkSet("Natu",Config.Jenkins.Natu.Staging),
                        LinkSet("ProtoBuf", Config.Jenkins.ProtoBuf.Staging)
                    ])
                    
                    hintRow("AllProject", [
                        "部署其他 Server",
                        "release 包版:",
                        "feature branch merge 進 demo branch ( 記得發MR )",
                        "jenkins Demo 部一版後，在 jenkins RC 包版",
                    ], [
                        LinkSet("Staging", Config.Jenkins.AllProject.Staging, copy: "*"),
                        LinkSet("Demo", Config.Jenkins.AllProject.Demo),
                        LinkSet("RC", Config.Jenkins.AllProject.RC),
                    ])
                    
                    hintRow("APIGateway", [
                        "部署 muffet",
                        "release 包版:",
                        "feature branch merge 進 demo branch ( 記得發MR )",
                        "jenkins Demo 部一版後，在 jenkins RC 包版",
                    ], [
                        LinkSet("Staging", Config.Jenkins.APIGateway.Staging, copy: "*"),
                        LinkSet("Demo", Config.Jenkins.APIGateway.Demo),
                        LinkSet("RC", Config.Jenkins.APIGateway.RC),
                    ])
                    
                    hintRow("Configmap", [
                        "Configmap 開發規則",
                        "RC/Prod 改 staging branch 並發 MR 給 SRE",
                        "＊ Staging/Demo/Hotfix 環境吃 staging branch",
                        "＊ RC/Prod 環境吃 master branch",
                    ], [
                        LinkSet("Staging", Config.Jenkins.Configmap.Staging),
                        LinkSet("Demo", Config.Jenkins.Configmap.Demo),
                        LinkSet("Hotfix", Config.Jenkins.Configmap.Hotfix),
                    ])
                    
                    hintRow("PairDeploy", [
                        "部署交易對",
                        "Configmap 要記得部署",
                    ], [
                        LinkSet("Staging", Config.Jenkins.PairDeploy.Staging),
                        LinkSet("Demo", Config.Jenkins.PairDeploy.Demo),
                        LinkSet("Hotfix", Config.Jenkins.PairDeploy.Hotfix),
                    ])
                    
                    hintRow("OrderCheck", [
                        "掉單檢查JOB",
                    ], [
                        LinkSet("Staging", Config.Jenkins.OrderCheck.Staging),
                        LinkSet("Demo", Config.Jenkins.OrderCheck.Demo),
                        LinkSet("Hotfix", Config.Jenkins.OrderCheck.Hotfix),
                    ])
                    
                    hintRow("OrderCancel", [
                        "掉單取消JOB",
                    ], [
                        LinkSet("Staging", Config.Jenkins.OrderCancel.Staging),
                        LinkSet("Demo", Config.Jenkins.OrderCancel.Demo),
                        LinkSet("Hotfix", Config.Jenkins.OrderCancel.Hotfix),
                    ])
                }
                
                hintBlock()
                    .padding(.leading)
                
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    private func hintRow(_ title: String, _ hints: [String], _ set: [LinkSet]) -> some View {
        let gap: CGFloat = 10
        let labelWidth: CGFloat = 90
        HStack(spacing: gap) {
            Text(title)
                .font(.system(size: 16, weight: .regular, design: .rounded))
                .frame(width: labelWidth, alignment: .leading)
            if set.count == 0 {
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: rowWidth - 90, height: 25)
                    .foregroundColor(.background2)
                    .overlay {
                        Text("僅顯示說明")
                            .foregroundColor(.section)
                    }
            } else {
                let count = CGFloat(set.count)
                let width = ( rowWidth - labelWidth - (gap * (count - 1))) / count
                ForEach(set, id: \.self) { s in
                    ButtonLink(name: s.title, link: s.link, copy: s.copy, width: width)
                }
            }
        }
        .onHover { _ in
            self.hints = hints
        }
    }
    
    @ViewBuilder
    private func hintBlock() -> some View {
        Text(hints.count == 0 ? "部署提示" : hints[0])
            .font(.system(size: 16, weight: .medium))
            .padding(.vertical, 5)
        
        VStack(alignment: .leading, spacing: 7) {
            ForEach(hints.indices, id: \.self) { i in
                if i != 0 {
                    Text(hints[i])
                }
            }
        }
        .frame(height: 80, alignment: .top)
    }
}

#if Debug
struct Deployment_Previews: PreviewProvider {
    static var previews: some View {
        Deployment()
            .frame(size: Config.menubarSize)
    }
}
#endif
