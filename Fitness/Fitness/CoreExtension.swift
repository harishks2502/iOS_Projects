//
//  CoreExtension.swift
//  Fitness
//
//  Created by admin on 01/02/25.
//

import Foundation

extension Workout {
    var exercisesArray: [Exercise] {
        let exercisesSet = self.exercises as? Set<Exercise>
        let exercisesArray = exercisesSet?.sorted { $0.name ?? "" < $1.name ?? "" } ?? []
        return exercisesArray
    }
}
