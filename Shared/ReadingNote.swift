//
//  TabBar.swift
//  Reader (iOS)
//
//  Created by jinzhao wang on 2022/8/11.
//

import SwiftUI
import BetterSafariView

struct ReadingNote: View {
    let text = "在外部打开"
    let image = "circle"
    @State var presentingSafarview = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        Link(destination: URL(string: "https://sspai.com/post/64899")!) {
                            RoundButton(text: text, image: "image")
                        }.padding(8)
                        
                        // 用第三方库BetterSafariView 跳转外部链接
                        Button {
                            self.presentingSafarview = true
                        } label: {
                            RoundButton(text: "在应用内打开", image: "arrow.up.forward.app")
                        }
                        .safariView(isPresented: $presentingSafarview) {
                            SafariView (
                                url: URL(string: "https://sspai.com/series/147/list")!,
                                configuration: SafariView.Configuration(entersReaderIfAvailable: true, barCollapsingEnabled: true)
                                // 是否自动进入阅读器视图 entersReaderIfAvailable; 是否允许浏览器自动折叠 barCollapsingEnabled
                            )
                            .preferredBarAccentColor(.clear) // 用于定制浏览器标签栏背景的颜色
                            .preferredControlAccentColor(Color("AccentColor")) // 定制标签栏按钮的颜色
                            .dismissButtonStyle(.close)  // 定制返回按钮的文字提示
                        }
                        // etterSafariView 框架的作者提供了三类修改器：.preferredBarAccentColor() 用于定制浏览器标签栏背景的颜色、.preferredControlAccentColor() 、.dismissButtonStyle()
                    }
                }
                Spacer()
                NoteEntryAndList()
            }
            .navigationTitle("链接")
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        ReadingNote()
    }
}

struct RoundButton: View {
    let text: String
    let image: String
    
    var body: some View {
        HStack {
            Text(text)
            Image(systemName: image)
        }
        .font(.headline)
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .foregroundColor(Color.white)
        .background(Color.accentColor)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

