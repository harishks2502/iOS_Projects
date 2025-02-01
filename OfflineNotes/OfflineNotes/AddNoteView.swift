//
//  AddNoteView.swift
//  OfflineNotes
//
//  Created by admin on 31/01/25.
//

import SwiftUI

struct AddNoteView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String = ""
    @State private var content: String = ""
    @State private var dateCreated = Date()
    
    var body: some View {
        NavigationView {
            Form {
                Section(
                    header: Text("Note Details")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .center)
                ) {
                    TextField("Enter Title", text: $title)
                        .font(.system(size: 18))
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                    
                    TextEditor(text: $content)
                        .frame(height: 200)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                    
                    DatePicker("Select Date", selection: $dateCreated, displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .padding()
                }
            }
            .navigationBarTitle("Add New Note", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Add New Note")
                        .font(.system(size: 22, weight: .bold))
                        .padding(.top, 10)
                        .padding(.bottom, 5)
                }
            }
            .navigationBarItems(
                leading: Button("Cancel") {
                    dismiss()
                },
                trailing: Button("Save") {
                    addNote()
                    dismiss()
                }
                    .disabled(title.isEmpty || content.isEmpty)
                    .font(.system(size: 18))
            )
        }
    }
    
    private func addNote() {
        let newNote = Notes(context: viewContext)
        
        newNote.title = title
        newNote.dateCreated = dateCreated
        newNote.content = content
        
        do {
            try viewContext.save()
        } catch {
            print("Error saving note: \(error)")
        }
        
    }
    
}

struct AddNoteView_Previews: PreviewProvider {
    static var previews: some View {
        AddNoteView()
    }
}
