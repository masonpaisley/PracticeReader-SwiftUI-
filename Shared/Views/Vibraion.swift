//
//  Vibraion.swift
//  Reader (iOS)
//
//  Created by jinzhao wang on 2022/8/10.
//

import SwiftUI

// 震动控制
enum Vibration {
    case error
    case success
    case light
    case selection
    
    func vibrate() {
        switch self {
        case .error:
            UINotificationFeedbackGenerator().notificationOccurred(.error)
        case .success:
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        case .light:
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        case .selection:
            UISelectionFeedbackGenerator().selectionChanged()
        }
    }
}
