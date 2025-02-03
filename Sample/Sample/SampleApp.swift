//
//  SampleApp.swift
//  Sample
//
//  Created by admin on 03/02/25.
//

import SwiftUI

@main
struct SampleApp: App {
    let persistentController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistentController.container.viewContext)
        }
    }
}
