//
//  ExerciseListView.swift
//  FitnessApp
//
//  Created by admin on 31/01/25.
//

import SwiftUI
import CoreData

struct ExerciseListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var workout: Workout

    @State private var isShowingAddExercise = false

    // Assuming `workout` is a valid Workout object
    func fetchExercises(for workout: Workout) -> [Exercise] {
        let exercisesSet = workout.exercises as? Set<Exercise>
        return exercisesSet?.sorted { $0.name ?? "" < $1.name ?? "" } ?? []
    }

    
    var body: some View {
        VStack {
            List {
                ForEach(workout.exercisesArray, id: \.self) { exercise in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(exercise.name ?? "Unnamed Exercise")
                                .font(.headline)
                            Text("\(exercise.sets) sets, \(exercise.reps) reps")
                                .font(.subheadline)
                        }
                    }
                }
                .onDelete(perform: deleteExercises)
            }
            .navigationTitle(workout.name ?? "Workout")
            .navigationBarItems(
                trailing: Button(action: { isShowingAddExercise = true }) {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $isShowingAddExercise) {
                AddExerciseView(workout: workout)
            }
        }
    }

    private func deleteExercises(at offsets: IndexSet) {
        for index in offsets {
            let exercise = workout.exercisesArray[index]
            viewContext.delete(exercise)
        }
        saveContext()
    }

    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Failed to save context: \(error.localizedDescription)")
        }
    }
}
