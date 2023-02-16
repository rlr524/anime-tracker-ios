//
//  DataController.swift
//  AnimeTracker
//
//  Created by Rob Ranf on 2/15/23.
//

import CoreData

class DataController: ObservableObject {
    let container: NSPersistentCloudKitContainer
    
    @Published var selectedFilter: Filter? = Filter.watching
    
    static var preview: DataController = {
        let dataController = DataController(inMemory: true)
        dataController.createSampleData()
        return dataController
    }()
    
    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Main")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(filePath: "/dev/null")
        }
        
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Fatal error loading store: \(error.localizedDescription)")
            }
        }
    }
    
    func createSampleData() {
        let viewContext = container.viewContext
        let tags = ["shonen", "fantasy", "magic", "action", "cgdct"]
        
        for i in tags {
            let tag = Tag(context: viewContext)
            tag.id = UUID()
            tag.title = "\(i)"
            
            for j in 1...10 {
                let anime = Anime(context: viewContext)
                anime.id = UUID()
                anime.title = "Anime \(j)"
                anime.descShort = "Short description here"
                anime.dateCreated = Date.now
                tag.addToAnimes(anime)
                
                for k in 1...10 {
                    let status = Status(context: viewContext)
                    status.id = UUID()
                    status.watchStatus = "watching"
                    status.rating = Int16.random(in: 0...9)
                    status.notes = "Notes for status \(k)"
                    status.dateCreated = Date.now
                    
                    for l in 1...10 {
                        let user = User(context: viewContext)
                        user.id = UUID()
                        user.userName = "UserName\(l)"
                        user.dateCreated = Date.now
                        user.statuses = []
                    }
                }
            }
        }
        
        try? viewContext.save()
    }
    
    func save() {
        if container.viewContext.hasChanges {
            try? container.viewContext.save()
        }
    }
    
    func delete(_ object: NSManagedObject) {
        container.viewContext.delete(object)
        save()
    }
    
    private func delete(_ fetchRequest: NSFetchRequest<NSFetchRequestResult>) {
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        batchDeleteRequest.resultType = .resultTypeObjectIDs
        
        if let delete = try? container.viewContext.execute(batchDeleteRequest)
                                                as? NSBatchDeleteResult {
            let changes = [NSDeletedObjectsKey: delete.result as? [NSManagedObjectID] ?? []]
            NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes,
                                                into: [container.viewContext])
        }
    }
    
    func deleteAll() {
        let requestOne: NSFetchRequest<NSFetchRequestResult> = Tag.fetchRequest()
        delete(requestOne)
        
        let requestTwo: NSFetchRequest<NSFetchRequestResult> = Anime.fetchRequest()
        delete(requestTwo)
        
        let requestThree: NSFetchRequest<NSFetchRequestResult> = Status.fetchRequest()
        delete(requestThree)
        
        let requestFour: NSFetchRequest<NSFetchRequestResult> = User.fetchRequest()
        delete(requestFour)
        
        save()
    }
}
