//
//  EditNoteView.swift
//  OfflineNotes
//
//  Created by admin on 31/01/25.
//

import SwiftUI

struct EditNoteView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var note: Notes
    
    @State private var title = ""
    @State private var content = ""
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
                    TextField("Edit Title", text: $title)
                        .font(.system(size: 18))
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
            .navigationBarTitle("Edit Note", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Edit Note")
                        .font(.system(size: 22, weight: .bold))
                        .padding(.top, 10)
                        .padding(.bottom, 5)
                }
            }
            .navigationBarItems(
                leading: Button("Cancel") {
                    dismiss()
                },
                trailing: Button("Update") {
                    updateNote()
                    dismiss()
                }
                    .disabled(title.isEmpty || content.isEmpty)
                    .font(.system(size: 18))
            )
            .onAppear {
                title = note.title ?? ""
                content = note.content ?? ""
                dateCreated = note.dateCreated ?? Date()
            }
        }
    }
    
    private func updateNote() {
        note.title = title
        note.dateCreated = dateCreated
        note.content = content
        
        do {
            try viewContext.save()
        } catch {
            print("Error updating note: \(error)")
        }
        
    }
    
}


