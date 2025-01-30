//
//  UserAppApp.swift
//  UserApp
//
//  Created by admin on 28/01/25.
//

import SwiftUI

@main
struct UserAppApp: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}


