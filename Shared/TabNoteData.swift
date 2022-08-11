//
//  TabNoteData.swift
//  Reader (iOS)
//
//  Created by jinzhao wang on 2022/8/11.
//

import Foundation

// Model
struct Note: Codable, Identifiable {
    var id: UUID
    var title: String
    var content: String
}

// ModelView
class TabNoteData: ObservableObject {
    @Published var notes = [Note]()
    
    // 获取沙盒路径,让 FileManager 在用户可存取的空间中 userDomainMask，查找负责存储文件 documentDirectory 的默认沙盒地址
    static let sandboxURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let notesURL = sandboxURL.appendingPathComponent("notes.json")
    
    init() {
        notes = getNotes()
    }
    
    // getNotes() 负责读取本地的 JSON 文件，并返回 [notes] 数组；saveNotes() 负责将数据存储到本地
    func getNotes() -> [Note] {
        var result = [Note]()
        
        // 如果没有文件，则返回空数组
        if FileManager.default.fileExists(atPath: notesURL.path) {
            let data = try! Data(contentsOf: notesURL) // 则尝试读取该文件中的内容，并将解码所得结果赋值在 result 中并返回
            result = try! JSONDecoder().decode([Note].self, from: data)
        }
        return result
    }
    
    func saveNotes() {
        // 存取过程一般比较耗时，可以使用 GCD 任务分配，将该任务放在后台线程中
        DispatchQueue.global(qos: .userInitiated).async {
            let data = try? JSONEncoder().encode(self.notes) // 到 JSON 编码器 JSONEncoder 来将现有数组加码成 JSON 数据
            try? data?.write(to: self.notesURL) // 将编码内容写入笔记 JSON 的地址中
        }
    }
}
