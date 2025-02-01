//
//  OfflineNotesApp.swift
//  OfflineNotes
//
//  Created by admin on 31/01/25.
//

import SwiftUI

@main
struct OfflineNotesApp: App {
    let persistentController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            NotesView()
                .environment(\.managedObjectContext, persistentController.container.viewContext)
        }
    }
}
