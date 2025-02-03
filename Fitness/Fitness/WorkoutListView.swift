//
//  WorkoutListView.swift
//  Fitness
//
//  Created by admin on 01/02/25.
//

import SwiftUI
import CoreData

struct WorkoutListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: Workout.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Workout.date, ascending: false)]
    ) private var workouts: FetchedResults<Workout>
    
    @State private var isShowingAddWorkout = false
    @State private var isShowingEditWorkout = false
    @State private var selectedWorkout: Workout?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(workouts) { workout in
                    HStack{
                        NavigationLink(destination: ExerciseListView(workout: workout)) {
                            VStack(alignment: .leading, spacing: 5) {
                                Text(workout.title ?? "Unnamed Workout")
                                    .padding(.top, 10)
                                    .padding(.bottom, 5)
                                    .font(.system(size: 20, weight: .semibold))
                                
                                Text("\(workout.date ?? Date(), formatter: workoutDateFormatter)")
                                    .font(.system(size: 18))
                                    .foregroundColor(.secondary)
                            }
                        }
                        Spacer()
                        
                        Button(action: {
                            selectedWorkout = workout
                            isShowingEditWorkout = true
                        }) {
                            Image(systemName: "pencil")
                                .foregroundColor(.blue)
                                .font(.system(size: 30))
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                }
                .onDelete(perform: deleteWorkout)
            }
            .navigationBarTitle("Workouts", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Workouts")
                        .font(.title.bold())
                        .padding(.vertical, 5)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { isShowingAddWorkout = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isShowingAddWorkout) {
                AddWorkoutView()
            }
            .sheet(item: $selectedWorkout) { workout in
                EditWorkoutView(workout: workout)
            }
        }
    }
    
    private let workoutDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.timeZone = TimeZone(identifier: "Asia/Kolkata")
        return formatter
    } ()
    
    private func deleteWorkout(at offsets: IndexSet) {
        for index in offsets {
            let workout = workouts[index]
            viewContext.delete(workout)
        }
        
        DispatchQueue.main.async {
            do {
                try viewContext.save()
            } catch {
                print("Error deleting workout: \(error.localizedDescription)")
            }
        }
    }
    
}
