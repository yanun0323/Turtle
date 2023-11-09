//
//  Deployment.swift
//  Bito Pro Secret
//
//  Created by YanunYang on 2022/7/13.
//

import SwiftUI
import Ditto

struct Deployment: View {
    @Environment(\.injected) private var container
    @State private var deployment: Secret.Bito.Deployment = Secret.default.bito.deployment
    @State private var hoverDeployment = false
    @State private var hoverConfigmap = false
    @State private var hints: [String] = []
    private let block: CGFloat = 10
    private let rowWidth: CGFloat = 330
    
    var body: some View {
        scrollView {
            VStack(alignment: .leading, spacing: 7.5)  {
                section("Jenkins", spacing: 7.5) {
                    hintRow("Deployment", deployment.deployment.description, [])
                    
                    hintRow("開發", [
                        "部署 Dependency Package",
                        "所有環境都是吃 development branch"
                    ], [
                        LinkSet("Natu", deployment.develop.natu ?? ""),
                        LinkSet("ProtoBuf", deployment.develop.protopuf ?? "")
                    ])
                    
                    hintRow("AllProject", deployment.allProject.description, [
                        LinkSet("Staging", deployment.allProject.staging ?? "", copy: "*"),
                        LinkSet("Demo", deployment.allProject.demo ?? ""),
                        LinkSet("RC", deployment.allProject.rc ?? ""),
                    ])
                    
                    hintRow("APIGateway", deployment.apiGateway.description, [
                        LinkSet("Staging", deployment.apiGateway.staging ?? "", copy: "*"),
                        LinkSet("Demo", deployment.apiGateway.demo ?? ""),
                        LinkSet("RC", deployment.apiGateway.rc ?? ""),
                    ])
                    
                    hintRow("Configmap", deployment.configMap.description, [
                        LinkSet("Staging", deployment.configMap.staging ?? ""),
                        LinkSet("Demo", deployment.configMap.demo ?? ""),
                        LinkSet("Hotfix", deployment.configMap.hotfix ?? ""),
                    ])
                    
                    hintRow("PairDeploy", deployment.pairDeploy.description, [
                        LinkSet("Staging", deployment.pairDeploy.staging ?? ""),
                        LinkSet("Demo", deployment.pairDeploy.demo ?? ""),
                        LinkSet("Hotfix", deployment.pairDeploy.hotfix ?? ""),
                    ])
                    
                    hintRow("OrderCheck", deployment.orderCheck.description, [
                        LinkSet("Staging", deployment.orderCheck.staging ?? ""),
                        LinkSet("Demo", deployment.orderCheck.demo ?? ""),
                        LinkSet("Hotfix", deployment.orderCheck.hotfix ?? ""),
                    ])
                    
                    hintRow("OrderCancel", deployment.orderCancel.description, [
                        LinkSet("Staging", deployment.orderCancel.staging ?? ""),
                        LinkSet("Demo", deployment.orderCancel.demo ?? ""),
                        LinkSet("Hotfix", deployment.orderCancel.hotfix ?? ""),
                    ])
                }
                
                hintBlock()
                    .padding(.leading)
                
                Spacer()
            }
        }
        .onReceive(container.appstate.secret) {
            guard let sec = $0 else { return }
            deployment = sec.bito.deployment
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

#Preview {
    Deployment()
        .frame(size: Config.menubarSize)
        .padding()
        .inject(.default)
}
