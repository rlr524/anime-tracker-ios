//
//  Tag-CoreDataHelpers.swift
//  AnimeTracker
//
//  Created by Rob Ranf on 2/17/23.
//

import Foundation

// Not doing getters and setters on tags as tags have no view reactivity,
// they are simply read and written.
extension Tag {
    var tagID: UUID {
        id ?? UUID()
    }
    
    var tagTitle: String {
        title ?? ""
    }
    
    var tagDateCreated: Date {
        dateCreated ?? Date.now
    }
    
    var tagDateUpdate: Date {
        dateUpdated ?? Date.now
    }
    
    var tagTopAnime: [Anime] {
        let result = animes?.allObjects as? [Anime] ?? []
        return result.filter { $0.averageRating > 8.0 }
    }
    
    static var example: Tag {
        let controller = DataController(inMemory: true)
        let viewContext = controller.container.viewContext
        
        let tag = Tag(context: viewContext)
        tag.id = UUID()
        tag.title = "Example Tag"
        return tag
    }
}

extension Tag: Comparable {
    public static func < (lhs: Tag, rhs: Tag) -> Bool {
        let left = lhs.tagTitle.localizedLowercase
        let right = rhs.tagTitle.localizedLowercase
        
        if left == right {
            return lhs.tagID.uuidString < rhs.tagID.uuidString
        } else {
            return left < right
        }
    }
}
