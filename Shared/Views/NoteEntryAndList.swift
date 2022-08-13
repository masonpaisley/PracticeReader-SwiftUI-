//
//  NoteEntryAndList.swift
//  Reader (iOS)
//
//  Created by jinzhao wang on 2022/8/12.
//

import SwiftUI
import ImagePickerView

struct NoteEntryAndList: View {
    @StateObject var noteData = TabNoteData()
    @State var titleInput = ""
    @State var contentInput = ""
    @State var image: UIImage?
    @State var showImagePicker: Bool = false
    
    var body: some View {
        VStack {
            // 添加、存储为JSON
            VStack(alignment: .leading, spacing: 20) {
                TextField("Title", text: $titleInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Content", text: $contentInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                HStack {
                    // 添加图片
                    Button {
                        showImagePicker.toggle()
                    } label: {
                        RoundButton(text: "add picture", image: "photo")
                    }
                    .sheet(isPresented: $showImagePicker) {
                        ImagePickerView(sourceType: .photoLibrary) { image in
                            self.image = image
                        }
                    }
                    
                    Spacer()
                    
                    // 添加笔记
                    Button {
                        save()
                    } label: {
                        RoundButton(text: "save", image: "note.text.badge.plus")
                    }
                }
                
                if image != nil {
                    Image(uiImage: image!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100, alignment: .center)
                        .cornerRadius(10)
                }
            }
            .padding()
            .background(Color(hex: "#F1F1F1"))
            .cornerRadius(5)
            .padding(.horizontal)
            
            // 读取现有笔记JSON
            List {
                ForEach(noteData.notes) { note in
                    VStack(alignment: .leading, spacing: 4) {
                        Text(note.title)
                            .bold()
                        Text(note.content)
                        if note.imageURLAppendix != nil {
                            Image(uiImage: noteData.getImage(note.imageURLAppendix!))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 80, height: 80, alignment: .center)
                                .cornerRadius(10)
                        }
                    }
                }
                .onDelete(perform: delete)
            }
            .listStyle(InsetGroupedListStyle())
        }
    }
    
    func delete(at offsets: IndexSet) {
        noteData.notes.remove(atOffsets: offsets)
        noteData.saveNotes()
    }
    
    func save() {
        let id = UUID()
        if let data = image?.pngData() {
            noteData.saveImage(id: id, data: data)
        } // 取可选类型参数 image，并将其转化为数据 data
        let newNote = Note(id: id, title: titleInput, content: contentInput, imageURLAppendix: image == nil ? nil : "\(id).png")
        noteData.notes.append(newNote) // 将其加入 noteData 所存储的笔记列表中
        noteData.saveNotes()
        titleInput = ""
        contentInput = ""
        image = nil
    }
}


struct NoteEntryAndList_Previews: PreviewProvider {
    static var previews: some View {
        NoteEntryAndList()
    }
}
