//
//  PersistentController.swift
//  OfflineNotes
//
//  Created by admin on 31/01/25.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    let container: NSPersistentContainer
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "OfflineNotes")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
            
        }
        
        container.loadPersistentStores {_ , error in
            if let error = error as NSError? {
                fatalError("Unresolved Error: \(error), \(error.userInfo)")
            }
        }
        
    }
        
    func saveContext() {
        let context = container.viewContext
        if context.hasChanges {
            try? context.save()
        }
    }
        
}
