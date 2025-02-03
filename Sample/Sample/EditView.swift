//
//  EditView.swift
//  Sample
//
//  Created by admin on 03/02/25.
//

import SwiftUI

struct EditView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var data: Data
    
    @State private var title: String = ""
    @State private var desc: String = ""
    @State private var date = Date()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Data Details")) {
                    TextField("Edit Title", text: $title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextEditor(text: $desc)
                        .frame(height: 200)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                    
                    DatePicker("Select Date", selection: $date, displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .padding()
                }
            }
            .navigationTitle("Edit Data")
            .navigationBarItems(
                leading: Button("Cancel") { dismiss() },
                trailing: Button("Save") {
                    updateData()
                    dismiss()
                }
                    .disabled(title.isEmpty || desc.isEmpty)
            )
            .onAppear {
                title = data.title ?? ""
                desc = data.desc ?? ""
                date = data.date ?? Date()
            }
        }
    }
    
    private func updateData() {
        data.title = title
        data.desc = desc
        data.date = date
        
        do {
            try viewContext.save()
        } catch {
            print("Error updating data: \(error.localizedDescription)")
        }
    }
    
}

