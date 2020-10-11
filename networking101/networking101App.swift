//
//  networking101App.swift
//  networking101
//
//  Created by Ron Machoka on 10/11/20.
//

import SwiftUI

@main
struct networking101App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
