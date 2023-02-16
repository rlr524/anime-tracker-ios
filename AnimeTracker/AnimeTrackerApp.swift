//
//  AnimeTrackerApp.swift
//  AnimeTracker
//
//  Created by Rob Ranf on 2/15/23.
//

import SwiftUI

@main
struct AnimeTrackerApp: App {
    @State var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController)
        }
    }
}
