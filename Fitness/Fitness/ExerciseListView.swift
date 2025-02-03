//
//  ExerciseListView.swift
//  Fitness
//
//  Created by admin on 01/02/25.
//

import SwiftUI

struct ExerciseListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var workout: Workout
    
    @State private var isShowingAddExercise = false
    @State private var isShowingEditExercise = false
    @State private var selectedExercise: Exercise?
    
    func fetchExercises(for workout: Workout) -> [Exercise] {
        let exercisesSet = workout.exercises as? Set<Exercise>
        return exercisesSet?.sorted { $0.name ?? "" < $1.name ?? "" } ?? []
    }
    
    var body: some View {
        VStack {
            List {
                ForEach(workout.exercisesArray, id: \.self) { exercise in
                    HStack {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(exercise.name ?? "Unnamed Exercise")
                                .font(.system(size: 20, weight: .semibold))
                            
                            Text("\(exercise.sets) sets, \(exercise.reps) reps")
                                .font(.subheadline)
                        }
                        Spacer()
                        
                        Button(action: {
                            selectedExercise = exercise
                            isShowingEditExercise = true
                        }) {
                            Image(systemName: "pencil")
                                .foregroundColor(.blue)
                                .font(.system(size: 30))
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                }
                .onDelete(perform: deleteExercise)
            }
            .navigationBarTitle("Exercises", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Exercises")
                        .font(.title.bold())
                        .padding(.vertical, 5)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { isShowingAddExercise = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isShowingAddExercise) {
                AddExerciseView(workout: workout)
            }
            .sheet(item: $selectedExercise) { exercise in
                EditExerciseView(exercise: exercise)
            }
        }
    }
    
    private func deleteExercise(at offsets: IndexSet) {
        for index in offsets {
            let exercise = workout.exercisesArray[index]
            viewContext.delete(exercise)
        }
        
        DispatchQueue.main.async {
            do {
                try viewContext.save()
            } catch {
                print("Failed to save context: \(error.localizedDescription)")
            }
        }
    }
    
}
