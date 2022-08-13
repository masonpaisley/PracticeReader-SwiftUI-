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

class TabReadingDate: ObservableObject {
    @Published var articles = [Article]()
    
    init () {
        let url = URL(string: "https://s3.us-west-2.amazonaws.com/secure.notion-static.com/493b35e1-e9c6-46c2-911f-8421c2c02b00/Directions.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20220813%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20220813T160533Z&X-Amz-Expires=86400&X-Amz-Signature=debf3393e61134097c2865aec2dd4b2a3a80c84d52b3e0ec1b64e9e8e2b73ab9&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Directions.json%22&x-id=GetObject")!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                self.articles = try! JSONDecoder().decode([Article].self, from: data!)
            }
        }.resume()
    }
}
