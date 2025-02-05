//
//  MilestoneApp.swift
//  Milestone
//
//  Created by admin on 03/02/25.
//

import SwiftUI

@main
struct MilestoneApp: App {
    let persistentController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            WorkoutListView()
                .environment(\.managedObjectContext, persistentController.container.viewContext)
        }
    }
}
