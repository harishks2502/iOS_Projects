//
//  EditExerciseView.swift
//  Fitness
//
//  Created by admin on 02/02/25.
//

import SwiftUI

struct EditExerciseView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) private var presentationMode
    
    @ObservedObject var exercise: Exercise
    
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
                        
                        Button("Update") {
                            updateExercise()
                        }
                        .disabled(name.isEmpty)
                        
                        Spacer()
                    }
                }
            }
            .navigationBarTitle("Edit Exercise", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Edit Exercise")
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
            .onAppear {
                name = exercise.name ?? ""
                reps = Int(exercise.reps)
                sets = Int(exercise.sets)
                
            }
        }
    }
    
    private func updateExercise() {
        exercise.name = name
        exercise.sets = Int32(sets)
        exercise.reps = Int32(reps)
        
        DispatchQueue.main.async {
            do {
                try viewContext.save()
                presentationMode.wrappedValue.dismiss()
            } catch {
                print("Failed to update exercise: \(error.localizedDescription)")
            }
        }
    }
    
}
