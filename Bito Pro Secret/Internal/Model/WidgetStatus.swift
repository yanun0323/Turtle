//
//  WidgetStatus.swift
//  Bito Pro Secret
//
//  Created by YanunYang on 2022/7/25.
//

import Foundation
import SwiftUI

private struct WidgetStatusKey: EnvironmentKey {
  static let defaultValue = false
}

extension EnvironmentValues {
    var widgetStatus: Bool {
        get { self[WidgetStatusKey.self] }
        set { self[WidgetStatusKey.self] = newValue }
      }
}
