//
//  ExcerciseListViewModel.swift
//  FitnessApp
//
//  Created by admin on 31/01/25.
//

import Foundation
import SwiftUI
import CoreData

class ExerciseListViewModel: ObservableObject {
    @Published var exercises: [Exercise] = []
    let workout: Workout

    init(workout: Workout) {
        self.workout = workout
        loadExercises()
    }

    var workoutName: String {
        workout.name ?? "Workout"
    }

    func loadExercises() {
        exercises = workout.exercisesArray
    }

    func deleteExercises(at offsets: IndexSet) {
        for index in offsets {
            let exercise = exercises[index]
            workout.managedObjectContext?.delete(exercise)
        }
        saveContext()
        loadExercises()
    }

    private func saveContext() {
        do {
            try workout.managedObjectContext?.save()
        } catch {
            print("Failed to save context: \(error.localizedDescription)")
        }
    }
}
