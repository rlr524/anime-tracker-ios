//
//  HomeView.swift
//  AnimeTracker
//
//  Created by Rob Ranf on 2/15/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var dataController: DataController
    let smartFilters: [Filter] = [.watching, .planToWatch]
    
    @FetchRequest(sortDescriptors:
                     [SortDescriptor(\.watchStatus)]) var statuses: FetchedResults<Status>
    
    var statusFilters: [Filter] {
        statuses.map { status in
            Filter(id: status.id ?? UUID(),
                   name: status.watchStatus ?? "No Status",
                   icon: "tag",
                   status: status)
        }
    }
    
    var body: some View {
        List(selection: $dataController.selectedFilter) {
            Section("Smart Filters") {
                ForEach(smartFilters) { filter in
                    NavigationLink(value: filter) {
                        Label(filter.name, systemImage: filter.icon)
                    }
                }
            }
            Section("Status") {
                ForEach(statusFilters) { filter in
                    NavigationLink(value: filter) {
                        Label(filter.name, systemImage: filter.icon)
                    }
                }
            }
        }
        .toolbar {
            Button {
                dataController.deleteAll()
                dataController.createSampleData()
            } label: {
                Label("ADD SAMPLES", systemImage: "flame")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(DataController.preview)
    }
}
