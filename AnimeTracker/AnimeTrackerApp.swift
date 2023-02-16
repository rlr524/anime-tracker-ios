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
            NavigationSplitView {
                HomeView()
            } content: {
                ContentView()
            } detail: {
                DetailView()
            }
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
        }
    }
}
