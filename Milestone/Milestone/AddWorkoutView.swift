//
//  AddWorkoutView.swift
//  Milestone
//
//  Created by admin on 04/02/25.
//

import SwiftUI

struct AddWorkoutView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var exerciseName = ""
    @State private var caloriesBurned = ""
    @State private var duration = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Exercise Details")) {
                    TextField("Enter Exercise", text: $exerciseName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Enter Calories Burned", text: $caloriesBurned)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Enter Duration", text: $duration)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }
            .navigationTitle("Add Exercise")
            .navigationBarItems(
                leading: Button("Cancel") { dismiss() },
                trailing: Button("Save") {
                    addExercise()
                    dismiss()
                }
                    .disabled(exerciseName.isEmpty || caloriesBurned.isEmpty || duration.isEmpty)
            )
        }
    }
    
    private func addExercise() {
        let newExercise = Workout(context: viewContext)
        newExercise.exerciseName = exerciseName
        newExercise.caloriesBurned = Double(caloriesBurned) ?? 0.0
        newExercise.duration = Double(duration) ?? 0.0
        
        DispatchQueue.main.async {
            do {
                try viewContext.save()
            } catch {
                print("Error adding workout: \(error.localizedDescription)")
            }
        }
    }
}

struct AddWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        AddWorkoutView()
    }
}
