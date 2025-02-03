//
//  AddWorkoutView.swift
//  Fitness
//
//  Created by admin on 01/02/25.
//

import SwiftUI

struct AddWorkoutView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode
    
    @State private var title: String = ""
    @State private var date = Date()
    
    var body: some View {
        NavigationView {
            Form {
                Section(
                    header: Text("Add Workout")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .center)
                ) {
                    TextField("Enter Workout Title", text: $title)
                        .font(.system(size: 18))
                        .padding(.vertical, 10)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    DatePicker("Select Date", selection: $date, displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .padding()
                }
                
                Section {
                    HStack {
                        Spacer()
                        
                        Button("Save") {
                            saveWorkout()
                        }
                        .disabled(title.isEmpty)
                        
                        Spacer()
                    }
                }
            }
            .navigationBarTitle("Add New Workout", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Add New Workout")
                        .font(.system(size: 22, weight: .bold))
                        .padding(.top, 10)
                        .padding(.bottom, 5)
                }
            }
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
    
    private func saveWorkout() {
        guard !title.isEmpty else { return }
        
        let newWorkout = Workout(context: viewContext)
        newWorkout.title = title
        newWorkout.date = date
        
        DispatchQueue.main.async {
            do {
                try viewContext.save()
                presentationMode.wrappedValue.dismiss()
            } catch {
                print("Failed to save workout: \(error.localizedDescription)")
            }
        }
    }
    
}
