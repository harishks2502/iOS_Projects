//
//  AddExerciseView.swift
//  FitnessApp
//
//  Created by admin on 31/01/25.
//

import SwiftUI

struct AddExerciseView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode

    @ObservedObject var workout: Workout

    @State private var exerciseName: String = ""
    @State private var sets: Int = 0
    @State private var reps: Int = 0

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Exercise Name", text: $exerciseName)
                    Stepper("Sets: \(sets)", value: $sets, in: 1...100)
                    Stepper("Reps: \(reps)", value: $reps, in: 1...100)
                }

                Section {
                    Button("Save") {
                        saveExercise()
                    }
                }
            }
            .navigationTitle("Add Exercise")
        }
    }

    private func saveExercise() {
        guard !exerciseName.isEmpty && sets > 0 && reps > 0 else { return }

        let newExercise = Exercise(context: viewContext)
        newExercise.name = exerciseName
        newExercise.sets = Int32(sets)
        newExercise.reps = Int32(reps)
        newExercise.workout = workout

        do {
            try viewContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            print("Failed to save exercise: \(error.localizedDescription)")
        }
    }
}
