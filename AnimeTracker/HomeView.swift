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
                     [SortDescriptor(\.title)]) var tags: FetchedResults<Tag>
    
    var tagFilters: [Filter] {
        tags.map { tag in
            Filter(id: tag.tagId,
                   name: tag.tagTitle,
                   icon: "tag",
                   tag: tag)
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
            Section("Tags") {
                ForEach(tagFilters) { filter in
                    NavigationLink(value: filter) {
                        Label(filter.name, systemImage: filter.icon)
                            .badge(filter.tag?.tagTopAnime.count ?? 0)
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
