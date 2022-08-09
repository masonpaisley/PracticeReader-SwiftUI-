//
//  ContentView.swift
//  Shared
//
//  Created by jinzhao wang on 2022/8/10.
//

import SwiftUI

struct ContentView: View {
    @StateObject var data = Data()
    
    var body: some View {
//        VStack {
//            Text("tuijian")
//            Divider()
//            List(data.articles) { article in
//                Row(article: article)
//            }
//        }
        NavigationView {
            List(data.articles) { article in
                Row(article: article)
            }
        }
        .navigationTitle("推荐")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Row: View {
    var article: Article
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(article.title)
                .font(.title)
                .padding(.bottom, 4)
            Text(article.body)
                .lineLimit(3)
        }
        .padding(.vertical, 12)
    }
}
