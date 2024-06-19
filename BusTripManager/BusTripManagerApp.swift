//
//  BusTripManagerApp.swift
//  BusTripManager
//
//  Created by Raul Montoya Perez on 19/6/24.
//

import SwiftUI

@main
struct BusTripManagerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
