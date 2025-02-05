//
//  WorkoutListView.swift
//  Milestone
//
//  Created by admin on 04/02/25.
//

import SwiftUI

struct WorkoutListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: Workout.entity(),
        sortDescriptors: []
    )private var workouts: FetchedResults<Workout>
    
    @State private var showAddWorkoutView = false
    @State private var editWorkout: Workout?
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(workouts) { workout in
                        NavigationLink(destination: EditWorkoutView(workout: workout)) {
                            VStack(alignment: .leading, spacing: 5) {
                                Text(workout.exerciseName ?? "No title")
                                    .font(.title2)
                                    .padding(.vertical, 5)
                                
                                Text("Calories Burned: \(workout.caloriesBurned, specifier: "%.2f") cal")
                                    .font(.title3)
                                    .padding(.vertical, 5)
                                
                                Text("Duration: \(workout.duration, specifier: "%.2f") min")
                                    .font(.title3)
                                    .padding(.vertical, 5)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        .swipeActions {
                            Button(role: .destructive) {
                                deleteWorkout(workout)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
            }
            .navigationTitle("Workouts List")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showAddWorkoutView = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddWorkoutView) {
                AddWorkoutView()
            }
        }
    }
    
    private func deleteWorkout(_ workout : Workout) {
        viewContext.delete(workout)
        
        DispatchQueue.main.async {
            do {
                try viewContext.save()
            } catch {
                print("Error deleting workout: \(error.localizedDescription)")
            }
        }
    }

}

struct WorkoutListView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutListView()
    }
}
