//
//  K8S.swift
//  Bito Pro Secret
//
//  Created by YanunYang on 2022/8/16.
//

import SwiftUI
import Ditto

struct Monitor: View {
    @Environment(\.injected) private var container
    @State private var monitor: Secret.Bito.Monitor = Secret.default.bito.monitor
    private let block: CGFloat = 10
    private let rowWidth: CGFloat = 300
    
    var body: some View {
        scrollView {
            section("K8S") {
                HStack(spacing: 5) {
                    TextLink(name: "Staging", link: monitor.k8s.staging.url, copy: monitor.k8s.staging.token)
                    ButtonCopy(name: "帳號", copy: monitor.k8s.staging.username)
                    ButtonCopy(name: "密碼", copy: monitor.k8s.staging.password)
                    ButtonCopy(name: "Token", copy: monitor.k8s.staging.token)
                }
                
                HStack(spacing: 5) {
                    TextLink(name: "Production", link: monitor.k8s.production.url, copy: monitor.k8s.production.token)
                    ButtonCopy(name: "帳號", copy: monitor.k8s.production.username)
                    ButtonCopy(name: "密碼", copy: monitor.k8s.production.password)
                    ButtonCopy(name: "Token", copy: monitor.k8s.production.token)
                }
            }
            
            section("Other") {
                linkRow("Metabase", [CopySet("Production", monitor.other.metabase)])
                linkRow("Grafana", [CopySet("Dev / Prod", monitor.other.grafana)])
                linkRow("OpenSearch", [CopySet("Dev / Prod", monitor.other.openSearch)])
                linkRow("OneSignal", [CopySet("Develop", monitor.other.oneSignal)])
                linkRow("Kafdrop",[
                    CopySet("Production", monitor.other.kafdrop.production),
                ])
                linkRow("",[
                    CopySet("Stg", monitor.other.kafdrop.staging),
                    CopySet("Demo",  monitor.other.kafdrop.demo),
                    CopySet("Hotfix", monitor.other.kafdrop.hotfix),
                ])
                linkRow("Pro 後台",[
                    CopySet("Production", monitor.other.admin.production),
                ])
                linkRow("",[
                    CopySet("Stg", monitor.other.admin.staging),
                    CopySet("Demo",  monitor.other.admin.demo),
                    CopySet("Hotfix", monitor.other.admin.hotfix),
                ])
            }
            
            Spacer()
        }
        .onReceive(container.appstate.secret) {
            guard let sec = $0 else { return }
            monitor = sec.bito.monitor
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

#Preview {
    Monitor()
        .frame(size: Config.menubarSize)
        .padding()
        .inject(.default)
}
