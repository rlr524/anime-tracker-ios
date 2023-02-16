//
//  Filter.swift
//  AnimeTracker
//
//  Created by Rob Ranf on 2/15/23.
//

import Foundation

struct Filter: Identifiable, Hashable {
    var id: UUID
    var name: String
    var icon: String
    var tag: Tag?
    
    static var watching = Filter(id: UUID(), name: "Currently Watching", icon: "sparkles.tv")
    static var planToWatch = Filter(id: UUID(), name: "Plan to Watch", icon: "list.star")
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: Filter, rhs: Filter) -> Bool {
        lhs.id == rhs.id
    }
}
