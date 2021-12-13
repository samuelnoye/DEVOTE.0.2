//
//  DEVOTE_0_2App.swift
//  DEVOTE.0.2
//
//  Created by Samuel Noye on 13/12/2021.
//

import SwiftUI

@main
struct DEVOTE_0_2App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
