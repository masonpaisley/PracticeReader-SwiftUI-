//
//  LocalRecord.swift
//  Reader (iOS)
//
//  Created by jinzhao wang on 2022/8/13.
//

import SwiftUI

struct LocalRecord: View {
    @State var title = ""
    @State var content = ""
    @Environment(\.managedObjectContext) var viewContext
    // 发送数据库读取请求，并将结果放在变量 records 中
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Entity.timestamp, ascending: false)], animation: .default) // 发出数据库读取申请时，要使用 sortDescriptors 来描述返回结果的排序方式。此处为降序
    var records: FetchedResults<Entity>
    
    var body: some View {
        VStack {
            NavigationView {
                VStack(alignment: .trailing, spacing: 20) {
                    TextField("Title", text: $title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Content", text: $content)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button {
                        Vibration.selection.vibrate()
                        saveRecord()
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil) // 关闭软键盘
                    } label: {
                        RoundButton(text: "save", image: "checkmark.circle.fill")
                    }
                    
                    List {
                        ForEach(records) { record in
                            VStack(alignment: .leading, spacing: 4) {
                                if record.timestamp != nil {
                                    Text("标题：\(record.title!)")
                                        .bold()
                                    Text("正文：\(record.content!)")
                                    HStack {
                                        Text("时间：")
                                        Text(record.timestamp!, style: .time)
                                    }
                                } else {
                                    Text("暂无数据")
                                }
                            }
                        }
                    }
                    Spacer()
                }
                .padding()
                .navigationTitle("记录")
            }
        }
    }
    
    // 存储到 Entity 数据库
    func saveRecord() {
        let new = Entity(context: viewContext)
        new.timestamp = Date()
        new.content = content
        new.title = title
        
        try? viewContext.save()
        
        title = ""
        content = ""
    }
}

struct LocalRecord_Previews: PreviewProvider {
    static var previews: some View {
        LocalRecord()
    }
}

