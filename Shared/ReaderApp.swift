//
//  ReaderApp.swift
//  Shared
//
//  Created by jinzhao wang on 2022/8/10.
//

import SwiftUI

@main
struct ReaderApp: App {
    let motionManager = MotionManager()
    
    var body: some Scene {
        WindowGroup {
            Master()
                .environmentObject(motionManager) // 用于把这个信息传递给应用的其它视图使用
        }
    }
}
