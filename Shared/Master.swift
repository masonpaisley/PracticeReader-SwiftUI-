//
//  ContentView.swift
//  Shared
//
//  Created by jinzhao wang on 2022/8/10.
//

import SwiftUI

struct Master: View {
    @StateObject var data = Data()
    
    var body: some View {
        NavigationView {
            List(data.articles) { article in
                NavigationLink (destination: ArticleDetail(article: article)) {
                    Row(article: article)
                }
            }
        }
        .navigationTitle("21321")
//        VStack {
//            Text("tuijian")
//            Divider()
//            List(data.articles) { article in
//                Row(article: article)
//            }
//        }
    }
}

struct Master_Previews: PreviewProvider {
    static var previews: some View {
        Master()
    }
}

struct Row: View {
    var article: Article
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(article.title)
                .font(.title2)
                .padding(.bottom, 4)
            Text(article.body)
                .lineLimit(3)
        }
        .padding(.vertical, 12)
    }
}
