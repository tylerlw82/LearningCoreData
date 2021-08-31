//
//  LearningCoreDataApp.swift
//  LearningCoreData
//
//  Created by Tyler Watt on 2021-08-29.
//

import SwiftUI

@main
struct LearningCoreDataApp: App {
    
    @Environment(\.scenePhase) var scenePhase
    
    let persistenceController = PersistenceController.shared

    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }.onChange(of: scenePhase) { _ in
            persistenceController.saveContext()
        }
    }
}
