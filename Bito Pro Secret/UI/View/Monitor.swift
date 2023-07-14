//
//  K8S.swift
//  Bito Pro Secret
//
//  Created by YanunYang on 2022/8/16.
//

import SwiftUI
import Ditto

struct Monitor: View {
    private let block: CGFloat = 10
    private let rowWidth: CGFloat = 300
    
    var body: some View {
        scrollView {
            section("K8S") {
                HStack(spacing: 5) {
                    TextLink(name: "Staging", link: Config.K8s.Staging.Link, copy: Config.K8s.Staging.Token)
                    ButtonCopy(name: "帳號", copy: Config.K8s.Staging.User)
                    ButtonCopy(name: "密碼", copy: Config.K8s.Staging.Password)
                    ButtonCopy(name: "Token", copy: Config.K8s.Staging.Token)
                }
                
                HStack(spacing: 5) {
                    TextLink(name: "Production", link: Config.K8s.Production.Link, copy: Config.K8s.Production.Token)
                    ButtonCopy(name: "帳號", copy: Config.K8s.Production.User)
                    ButtonCopy(name: "密碼", copy: Config.K8s.Production.Password)
                    ButtonCopy(name: "Token", copy: Config.K8s.Production.Token)
                }
                
                HStack(spacing: 5) {
                    TextLink(name: "Ex-Stg", link: Config.K8s.StagingEx.Link, copy: Config.K8s.StagingEx.Token)
                    ButtonCopy(name: "帳號", copy: Config.K8s.StagingEx.User)
                    ButtonCopy(name: "密碼", copy: Config.K8s.StagingEx.Password)
                    ButtonCopy(name: "Token", copy: Config.K8s.StagingEx.Token)
                }
                
                HStack(spacing: 5) {
                    TextLink(name: "Ex-Prod", link: Config.K8s.ProductionEx.Link, copy: Config.K8s.ProductionEx.Token)
                    ButtonCopy(name: "帳號", copy: Config.K8s.ProductionEx.User)
                    ButtonCopy(name: "密碼", copy: Config.K8s.ProductionEx.Password)
                    ButtonCopy(name: "Token", copy: Config.K8s.ProductionEx.Token)
                }
            }
            
            section("Other") {
                linkRow("Metabase", [CopySet("Production", Config.Monitor.Metabase)])
                linkRow("Grafana", [CopySet("Dev / Prod", Config.Monitor.Grafana)])
                linkRow("OpenSearch", [CopySet("Dev / Prod", Config.Monitor.OpenSearch)])
                linkRow("OneSignal", [CopySet("Develop", Config.Monitor.OneSignal)])
                linkRow("Kafdrop",[
                    CopySet("Production", Config.Monitor.KafdropProduction),
                ])
                linkRow("",[
                    CopySet("Stg",Config.Monitor.KafdropStaging),
                    CopySet("Demo", Config.Monitor.KafdropDemo),
                    CopySet("Hofix",Config.Monitor.KafdropHotfix),
                ])
                linkRow("Pro 後台",[
                    CopySet("Production", Config.Monitor.BitoBackProduction),
                ])
                linkRow("",[
                    CopySet("Stg",Config.Monitor.BitoBackStaging),
                    CopySet("Demo", Config.Monitor.BitoBackDemo),
                    CopySet("Hofix",Config.Monitor.BitoBackHotfix),
                ])
            }
            
            Spacer()
        }
    }
    
    @ViewBuilder
    private func linkRow(_ title: String, _ sets: [CopySet]) -> some View {
        let gap: CGFloat = 10
        let labelWidth: CGFloat = 90
        HStack(spacing: gap) {
            Text(title)
                .font(.system(size: 16, weight: .regular, design: .rounded))
                .frame(width: labelWidth, alignment: .leading)
            let count = CGFloat(sets.count)
            let width = (rowWidth - labelWidth - (gap * (count - 1))) / count
            ForEach(sets, id: \.self) { s in
                ButtonLink(name: s.title, link: s.text, copy: s.sub, width: width)
            }
        }
    }
}

struct Monitor_Previews: PreviewProvider {
    static var previews: some View {
        Monitor()
            .frame(size: Config.menubarSize)
    }
}
