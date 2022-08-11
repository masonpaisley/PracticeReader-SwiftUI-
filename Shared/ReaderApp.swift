//
//  ReaderApp.swift
//  Shared
//
//  Created by jinzhao wang on 2022/8/10.
//

import SwiftUI
import LocalAuthentication


@main
struct ReaderApp: App {
    let motionManager = MotionManager()
    @State var locked = true
    
    var body: some Scene {
        WindowGroup {
            Group {
                if locked {
                    LockedView(authorize: authorize) // 当函数作为参数使用时，只需要使用其常量名即可
                } else {
                    TabView {
                        Master()
                            .environmentObject(motionManager) // 用于把这个信息传递给应用的其它视图使用
                            .tabItem {
                                Label("阅读", systemImage: "books.vertical")
                            }
                        ReadingNote()
                            .tabItem {
                                Label("笔记", systemImage: "note.text")
                            }
                    }
                }
            }
            .onAppear(perform: authorize) // 开机时，调用faceID
        }
    }
    
    // faceID识别
    func authorize() {
        // LAContext 中的 LA 是 Local Authentication 框架的缩写，它是开发者与该框架交互的中介
        let context = LAContext()
        // 变量 error 是 Local Authentication 框架要求开发者提供的错误类别，其类型为 NSError
        var error: NSError?
        
        // canEvaluatePolicy 是中介 context 所包含的一个函数，用途是判断设备是否支持 Face ID 或 Touch ID，如果支持，再继续进行识别
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "解锁应用") { result, _ in
                locked = !result
            }
        }
    }
}

struct LockedView: View {
    // Swift 中的函数也包含类型。函数的类型通常写作 () -> ()，指的是参数列为空的函数，无返回值，
    let authorize: () -> ()
    
    var body: some View {
        VStack {
            Image(systemName: "lock.shield")
                .font(.system(.largeTitle, design: .rounded))
            .padding(.bottom, 50)
            
            Button(action: {
                authorize()
                Vibration.light.vibrate()
            }, label: {
                Text("轻点再次尝试解锁")
                    .bold()
            })
        }
    }
}
