//
//  Info.swift
//  Bito Pro Secret
//
//  Created by YanunYang on 2022/7/19.
//

import SwiftUI
import Ditto

struct Info: View {
    @Environment(\.openURL) private var openURL
    private let info: [String] = [
        "0.7.4\n新功能：檢查新版本\n更新 MySQL Domain",
        "0.7.3\n移除CoreData底層資料庫",
        "0.7.2\n修正設定無法即時更改問題\n更新UI",
        "0.7.1\n修正撈取舊資料錯誤\n新增刪除按鈕確認",
        "0.7.0\n更新新增/修改按鈕介面\n修正新增/修改按鈕會導致APP凍結的問題\n新增連結按鈕同時拷貝字串\n底層資料庫轉換為純SQLite\n更新時間轉換工具",
        "0.6.8\n調整 Tab 順序\n合併「工具」「幣託」為「其他」\n新增複製 popup",
        "0.6.7\n更新 Open Search Link\n新增連結按鈕點選複製token功能",
        "0.6.6\n新增下載 Loading 頁",
        "0.6.5\n更新K8s Prod Token",
        "0.6.5\n更新K8s Prod Token",
        "0.6.4\nEKS搬移更新\n新增對連結按右鍵可以拷貝連結\n增加視窗高度",
        "0.6.3\n修正MySQL DB 帳密不同",
        "0.6.3\n修正有時要按兩下才複製的BUG\n更新 MySQL DB HOST\n新增 K8S EKS",
        "0.6.2\n修正閃退問題",
        "0.6.1\n快速切換功能排除版本及設定",
        "0.6.0\n新增小工具\n新增快速切換功能\n修改部署提示\n更新按鈕樣式及連結\n新增新版本確認功能",
        "0.5.2\n修正K8S Ex-Prod Token 錯誤",
        "0.5.1\n新增新人資系統入口\n修正新增/編輯自訂按鈕，overflow 問題",
        "0.5.0\n新增自訂按鈕修改功能\n變更刪除自訂按鈕方式",
        "0.4.7\n修改預設時間格式\n變更外觀按鈕樣式\n改善暗黑模式顏色辨識度\n",
        "0.4.6\n新增Unix Now功能\n修正Redis Hotfix Host錯誤",
        "0.4.5\n調整整體排版",
        "0.4.4\n修正自訂按鈕大小",
        "0.4.3\n修正自訂按鈕頁面跑版問題",
        "0.4.2\n修改新增按鈕位置",
        "0.4.1\n關閉程式按鈕移動至設定頁面",
        "0.4.0\n增加自訂按鈕拖拉排序功能",
        "0.3.7\n新增外觀選項",
        "0.3.6\n修正新增自訂按鈕排序問題",
        "0.3.5\n增加部署Widget(廢物)",
        "0.3.4\n修改小工具彈出樣式\n修正暗黑模式顏色不明顯問題",
        "0.3.3\n增加設定頁面\n修改新增按鈕樣式\n新增：拷貝後隱藏小工具設定\n新增：開啟連結後隱藏小工具設定\n新增：按兩下'版本說明' '設定'會回到原標籤頁",
        "0.3.2\n增加按鈕：部署/AllProject/RC\n增加包版說明",
        "0.3.1\n增加版本說明",
        "0.3.0\n修正自訂按鈕排序錯亂問題",
    ]
    
    var body: some View {
        VStack {
            Text("目前版本 \(Config.VERSION)")
                .fontWeight(.medium)
                .font(.title3)
            
            Button(width: 150, height: 23, color: .background, radius: 7) {
                Updater.checkForUpdate()
            } content: {
                Text("檢查新版本")
                    .foregroundLinearGradient([.blue, .glue])
                    .foregroundColor(.transparent)
            }
            .shadow(color: .section, radius: 3)
                
            scrollView {
                VStack(alignment: .leading, spacing: 10) {
                    ForEach(info, id: \.self) { text in
                        Text(text)
                    }
                }
                .padding()
            }
            Text("Developed By Yanun")
                .font(.caption)
                .foregroundColor(.primary25)
                .padding(.bottom, 5)
        }
    }
}

struct Info_Previews: PreviewProvider {
    static var previews: some View {
        Info()
            .frame(size: Config.menubarSize)
    }
}
