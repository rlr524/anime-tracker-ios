//
//  Status-CoreDataHelpers.swift
//  AnimeTracker
//
//  Created by Rob Ranf on 2/17/23.
//

import Foundation

extension Status {
    var statusId: UUID {
        id ?? UUID()
    }
    
    var statusWatchStatus: String {
        get { watchStatus ?? ""}
        set { watchStatus = newValue }
    }
    
    var statusNotes: String {
        get { notes ?? "" }
        set { notes = newValue }
    }
    
    var statusDateStarted: Date {
        dateStarted ?? Date.now
    }
    
    var statusDateFinished: Date {
        dateFinished ?? Date.now
    }
    
    var statusDateCreated: Date {
        dateCreated ?? Date.now
    }
    
    var statusDateUpdated: Date {
        dateUpdated ?? Date.now
    }
    
    static var example: Status {
        let controller = DataController(inMemory: true)
        let viewContext = controller.container.viewContext
        
        let status = Status(context: viewContext)
        status.id = UUID()
        status.watchStatus = "Watching"
        return status
    }
}

extension Status: Comparable {
    public static func < (lhs: Status, rhs: Status) -> Bool {
        let left = lhs.statusDateCreated
        let right = rhs.statusDateCreated
        
        if left == right {
            return lhs.statusId.uuidString < rhs.statusId.uuidString
        } else {
            return left < right
        }
    }
}
