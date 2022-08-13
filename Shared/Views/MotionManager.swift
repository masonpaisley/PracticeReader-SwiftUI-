//
//  MotionManager.swift
//  Reader (iOS)
//
//  Created by jinzhao wang on 2022/8/10.
//

import SwiftUI
import CoreMotion

// Core Motion 传感器框架
// 传感器中的信息作为程序中的视图结构 ViewModel，用途与前文定义的 Data 类似，负责提供并更新数据。同 Data 一样，传感器信息也定义为 class
class MotionManager: ObservableObject {
    let motionManager = CMMotionManager()
    
    // 当传感器信息变化时，x、y、z 的内容自动更新
    @Published var x: CGFloat = 0
    @Published var y: CGFloat = 0
    @Published var z: CGFloat = 0
    
    init() {
        motionManager.startDeviceMotionUpdates(to: .main) { data, _ in
            // 我们需要获得设备的倾斜度，可用 data?.gravity 来提取该信息
            // 因为有些设备可能不包含部分传感器，强行获取其数据可能会导致应用闪退，因此本例使用了 guard 语法来确认该信息可以被获取
            guard let tilt = data?.gravity else { return }
            
            self.x = CGFloat(tilt.x)
            self.y = CGFloat(tilt.y)
            self.z = CGFloat(tilt.z)
        }
    }
}
