//
//  DarkModeControl.swift
//  Reader (iOS)
//
//  Created by jinzhao wang on 2022/8/10.
//

import SwiftUI

// 黑暗模式控制
struct DarkModeControl: View {
    @Binding var darkMode: Bool
    
    var body: some View {
        Button(action: {
            Vibration.light.vibrate()
            darkMode.toggle()
        }, label: {
            Image(systemName: darkMode ? "sun.max.fill" : "moon.fill")
        })
    }
}

//
//struct DarkModeControl_Previews: PreviewProvider {
//    static var previews: some View {
//        DarkModeControl(darkMode: .constant(false))
//    }
//}
