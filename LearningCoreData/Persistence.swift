//
//  Persistence.swift
//  LearningCoreData
//
//  Created by Tyler Watt on 2021-08-29.
//

import CoreData

struct PersistenceController {
    let container: NSPersistentContainer
    
    static let shared = PersistenceController()
    
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        //Items
        let itemAdder = Item(context: viewContext)
        itemAdder.itemName = "Yadda yadda yadda ..."
        
        shared.saveContext()
        
        return result
    }()
    
    
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "LearningCoreData")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    
    
    // Better save
    func saveContext() {
        let context = container.viewContext
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
}
