//
//  FitnessAppApp.swift
//  FitnessApp
//
//  Created by admin on 31/01/25.
//

import SwiftUI



@main
struct FitnessAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            WorkoutListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
