//
//  ContentView.swift
//  Shared
//
//  Created by jinzhao wang on 2022/8/10.
//

import SwiftUI

struct Master: View {
    @StateObject var data = Data()
    @AppStorage("darkMode") var darkMode = false
    
    var body: some View {
        NavigationView {
            List(data.articles) { article in
                NavigationLink (destination: ArticleDetail(article: article)) {
                    Row(article: article)
                }
            }
            .navigationTitle("推荐")
            .toolbar {
                DarkModeControl(darkMode: $darkMode)
            }
        }
        .preferredColorScheme(darkMode ? .dark : .light)
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
                .fontWeight(.medium)
                .padding(.bottom, 4)
            Text(article.body)
                .font(.callout)
                .lineLimit(3)
        }
        .padding(.vertical, 12)
    }
}

