//
//  CoreExtension.swift
//  FitnessApp
//
//  Created by admin on 31/01/25.
//

import Foundation

//name, date , exerciseArray
//name, date, Set<Exercises>

    extension Workout {
        var exercisesArray: [Exercise] {
            // Safely cast NSSet to Set<Exercise> or return an empty set
            let exercisesSet = self.exercises as? Set<Exercise>
            let exercisesArray1 = exercisesSet?.sorted { $0.name ?? "" < $1.name ?? "" } ?? []
            return exercisesArray1
            }
        
        
    }

