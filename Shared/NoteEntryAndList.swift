//
//  NoteEntryAndList.swift
//  Reader (iOS)
//
//  Created by jinzhao wang on 2022/8/12.
//

import SwiftUI

struct NoteEntryAndList: View {
    @StateObject var noteData = TabNoteData()
    @State var titleInput = ""
    @State var contentInput = ""
    
    var body: some View {
        VStack {
            // 添加、存储为JSON
            VStack(alignment: .trailing, spacing: 20) {
                TextField("Title", text: $titleInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Content", text: $contentInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: {
                    let id = UUID()
                    let newNote = Note(id: id, title: titleInput, content: contentInput)
                    noteData.notes.append(newNote) // 将其加入 noteData 所存储的笔记列表中
                    noteData.saveNotes()
                    titleInput = ""
                    contentInput = ""
                }) {
                    RoundButton(text: "save", image: "note.text.badge.plus")
                }
            }
            .padding()
            .background(Color(hex: "#F1F1F1"))
            .cornerRadius(5)
//            .shadow(radius: 15)
            .padding()
            
            // 读取现有笔记JSON
            List {
                ForEach(noteData.notes) { note in
                    VStack(alignment: .leading, spacing: 20) {
                        Text(note.title)
                            .bold()
                        Text(note.content)
                    }
                }
                .onDelete(perform: delete)
            }
            .listStyle(InsetGroupedListStyle())
            
            Text("213")
        }
    }
    
    func delete(at offsets: IndexSet) {
        noteData.notes.remove(atOffsets: offsets)
        noteData.saveNotes()
    }
}


struct NoteEntryAndList_Previews: PreviewProvider {
    static var previews: some View {
        NoteEntryAndList()
    }
}
