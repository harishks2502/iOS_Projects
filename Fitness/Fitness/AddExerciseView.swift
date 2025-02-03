//
//  AddExerciseView.swift
//  Fitness
//
//  Created by admin on 01/02/25.
//

import SwiftUI

struct AddExerciseView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode
    
    @ObservedObject var workout: Workout
    
    @State private var name: String = ""
    @State private var sets: Int = 1
    @State private var reps: Int = 1
    
    var body: some View {
        NavigationView {
            Form {
                Section(
                    header: Text("Exercise Details")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .center)
                ) {
                    TextField("Enter exercise name", text: $name)
                        .font(.system(size: 18))
                        .padding(.vertical, 10)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Stepper("Sets: \(sets)", value: $sets, in: 1...20)
                    
                    Stepper("Reps: \(reps)", value: $reps, in: 1...30)
                }
                
                Section {
                    HStack {
                        Spacer()
                        
                        Button("Save") {
                            saveExercise()
                        }
                        .disabled(name.isEmpty)
                        
                        Spacer()
                    }
                }
            }
            .navigationBarTitle("Add New Exercise", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Add New Exercise")
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
    
    private func saveExercise() {
        guard !name.isEmpty && sets > 0 && reps > 0 else { return }
        
        let newExercise = Exercise(context: viewContext)
        newExercise.name = name
        newExercise.sets = Int32(sets)
        newExercise.reps = Int32(reps)
        newExercise.workout = workout
        
        DispatchQueue.main.async {
            do {
                try viewContext.save()
                presentationMode.wrappedValue.dismiss()
            } catch {
                print("Failed to save exercise: \(error.localizedDescription)")
            }
        }
    }
    
}
