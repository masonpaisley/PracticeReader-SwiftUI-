//
//  Extension.swift
//  Reader (iOS)
//
//  Created by jinzhao wang on 2022/8/12.
//

import SwiftUI


// 扩展Color 至 HEX
extension Color {
    init (hex : String) {
        let hex = hex . trimmingCharacters (in:
            CharacterSet . alphanumerics . inverted)
        var int: UInt64 = 0
        Scanner (string: hex ) . scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xFF) * 17, (int & 0xFF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF )
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double (r) / 255,
            green: Double(g) / 255,
            blue: Double (b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct GlassEffect: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemUltraThinMaterial
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style) )
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context:
                      Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}

extension View {
    func glassEffect() -> some View {
        self.background(GlassEffect())
    }
}

struct BlurView: UIViewRepresentable {
    let style: UIBlurEffect.Style
    
    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView{
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, at: 0)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor)])
        return view
    }
        
    func updateUIView(
        _ uiView: UIView,
        context: UIViewRepresentableContext<BlurView>
    ){}
}
