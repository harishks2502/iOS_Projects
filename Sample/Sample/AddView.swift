//
//  AddView.swift
//  Sample
//
//  Created by admin on 03/02/25.
//

import SwiftUI

struct AddView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var title: String = ""
    @State private var desc: String = ""
    @State private var date = Date()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Data Details")) {
                    TextField("Enter Title", text: $title)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextEditor(text: $desc)
                        .frame(height: 200)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                    
                    DatePicker("Select Date", selection: $date, displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .padding()
                }
            }
            .navigationTitle("Add Data")
            .navigationBarItems(
                leading: Button("Cancel") { dismiss() },
                trailing: Button("Save") {
                    addData()
                    dismiss()
                }
                    .disabled(title.isEmpty || desc.isEmpty)
            )
        }
    }
    
    private func addData() {
        let newData = Data(context: viewContext)
        newData.title = title
        newData.desc = desc
        newData.date = date
        
        do {
            try viewContext.save()
        } catch {
            print("Error saving data: \(error.localizedDescription)")
        }
    }
    
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}
