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
        let url = URL(string: "https://s3.us-west-2.amazonaws.com/secure.notion-static.com/d88de997-6033-4721-8a5e-c394189c337c/Directions.json?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Credential=AKIAT73L2G45EIPT3X45%2F20220810%2Fus-west-2%2Fs3%2Faws4_request&X-Amz-Date=20220810T144311Z&X-Amz-Expires=86400&X-Amz-Signature=1e2d72e8ee11869ee92ec299844c0e4d2fb7944b12a5992fb93a6108e96205c9&X-Amz-SignedHeaders=host&response-content-disposition=filename%20%3D%22Directions.json%22&x-id=GetObject")!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                self.articles = try! JSONDecoder().decode([Article].self, from: data!)
            }
        }.resume()
    }
}
