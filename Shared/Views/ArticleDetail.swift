//
//  ArticleDetail.swift
//  Reader (iOS)
//
//  Created by jinzhao wang on 2022/8/10.
//

import SwiftUI

struct ArticleDetail: View {
    var article: Article
    @EnvironmentObject var motion: MotionManager
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text(article.title)
                    .font(.title3)
                Text(article.body)
            }
            .offset(x: motion.x * 80, y: motion.y * 80)
            .scaleEffect(max(1, (0.7 + -motion.y * 0.4)))
            .rotation3DEffect(.degrees(motion.x * 80), axis: (x: 0, y: 1, z: 0))
            .padding()
        }
    }
}

//struct ArticleDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        ArticleDetail()
//    }
//}
