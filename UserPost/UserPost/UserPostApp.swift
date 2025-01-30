//
//  UserPostApp.swift
//  UserPost
//
//  Created by admin on 29/01/25.
//

import SwiftUI

@main
struct UserPostApp: App {
    let persistentController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            PostsView()
                .environment(\.managedObjectContext, persistentController.container.viewContext)
        }
    }
}
