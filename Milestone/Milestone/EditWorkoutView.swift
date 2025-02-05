//
//  EditWorkoutView.swift
//  Milestone
//
//  Created by admin on 04/02/25.
//

import SwiftUI

struct EditWorkoutView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var workout: Workout
    
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
            .navigationTitle("Edit Exercise")
            .navigationBarItems(
                leading: Button("Cancel") { dismiss() },
                trailing: Button("Save") {
                    updateExercise()
                    dismiss()
                }
                    .disabled(exerciseName.isEmpty || caloriesBurned.isEmpty || duration.isEmpty)
            )
            .onAppear {
                exerciseName = workout.exerciseName ?? ""
                caloriesBurned = String(format: "%.2f", workout.caloriesBurned)
                duration = String(format: "%.2f", workout.duration)
            }
        }
    }
    
    private func updateExercise() {
        workout.exerciseName = exerciseName
        workout.caloriesBurned = Double(caloriesBurned) ?? 0.0
        workout.duration = Double(duration) ?? 0.0
        
        DispatchQueue.main.async {
            do {
                try viewContext.save()
            } catch {
                print("Error adding workout: \(error.localizedDescription)")
            }
        }
    }
}

