//
//  EditWorkoutView.swift
//  Fitness
//
//  Created by admin on 03/02/25.
//

import SwiftUI

struct EditWorkoutView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var workout: Workout
    
    @State private var title: String = ""
    @State private var date = Date()
    
    var body: some View {
        NavigationView {
            Form {
                Section (
                    header: Text("Workout Details")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .center)
                ) {
                    TextField("Enter workout name", text: $title)
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
                        
                        Button("Update Workout") {
                            updateWorkout()
                        }
                        .disabled(title.isEmpty)
                        
                        Spacer()
                    }
                }
            }
            .navigationBarTitle("Edit Workout", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Edit Workout")
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
            .onAppear{
                title = workout.title ?? ""
                date = workout.date ?? Date()
            }
        }
    }
    
    private func updateWorkout() {
        workout.title = title
        workout.date = date
        
        DispatchQueue.main.async {
            do {
                try viewContext.save()
                presentationMode.wrappedValue.dismiss()
            } catch {
                print("Failed to update workout: \(error.localizedDescription)")
            }
        }
    }
    
}
