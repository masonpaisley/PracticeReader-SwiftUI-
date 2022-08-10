//
//  ArticleDetail.swift
//  Reader (iOS)
//
//  Created by jinzhao wang on 2022/8/10.
//

import SwiftUI

struct ArticleDetail: View {
    var article: Article
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text(article.title)
                    .font(.title3)
                Text(article.body)
            }
            .padding()
        }
    }
}

//struct ArticleDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        ArticleDetail()
//    }
//}
