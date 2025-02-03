//
//  FitnessApp.swift
//  Fitness
//
//  Created by admin on 01/02/25.
//

import SwiftUI

@main
struct FitnessApp: App {
    let persistentController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            WorkoutListView()
                .environment(\.managedObjectContext, persistentController.container.viewContext)
        }
    }
}
