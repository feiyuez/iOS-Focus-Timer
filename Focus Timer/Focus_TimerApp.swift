//
//  Focus_TimerApp.swift
//  Focus Timer
//
//  Created by Feiyue Zhang on 8/14/22.
//

import SwiftUI

@main
struct Focus_TimerApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
