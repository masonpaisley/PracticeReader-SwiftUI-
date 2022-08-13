//
//  CloudData.swift
//  Reader (iOS)
//
//  Created by jinzhao wang on 2022/8/13.
//

import CoreData

struct CloudData {
    static let shared = CloudData()
    
    // NSPersistentCloudKitConatiner 指的是一个支持本地和网络存储的数据库容器 Container，如果不用云存储，可以使用 NSPersistentContainer
    let container: NSPersistentContainer
    
    // 负责检查内存中是否已存在数据库，并在必要时加载
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Reader")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { _, _ in })
    }
}
