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
        VStack {
            Text(article.title)
            Text(article.body)
        }.padding()
    }
}

//struct ArticleDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        ArticleDetail()
//    }
//}
