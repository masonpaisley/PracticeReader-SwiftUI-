//
//  Article.swift
//  Reader (iOS)
//
//  Created by jinzhao wang on 2022/8/10.
//

import Foundation

struct Article: Codable, Identifiable {
    var id: Int
    var title: String
    var body: String
}

class Data: ObservableObject {
    @Published var articles = [Article]()
    
    init () {
        let url = URL(string: "https://s3.us-west-2.amazonaws.com/secure.notion-static.com/0407e7d5-9d61-4c05-b3ef-7b05c5de894b/Directions.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20220809%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20220809T164532Z&X-Amz-Expires=86400&X-Amz-Signature=0ec4685e7ad572b39c81ee1616ba2b391d939e7ebc5410b1b21faf15705d17e2&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Directions.json%22&x-id=GetObject")!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                self.articles = try! JSONDecoder().decode([Article].self, from: data!)
            }
        }.resume()
    }
}
