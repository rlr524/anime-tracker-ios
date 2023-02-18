//
//  Anime-CoreDataHelpers.swift
//  AnimeTracker
//
//  Created by Rob Ranf on 2/17/23.
//

import Foundation

// Do getters and setters on attributes that may gave view reactivity, e.g.
// the anime title will populate in the results list as a user searches for
// an anime to add.
extension Anime {
    var animeTitle: String {
        get {title ?? ""}
        set {title = newValue}
    }
    
    var animeSeason: String {
        get {season ?? ""}
        set {season = newValue}
    }
    
    var animeCour: String {
        get {cour ?? ""}
        set {cour = newValue}
    }
    
    var animeGenre: String {
        get {genre ?? ""}
        set {genre = newValue}
    }
    
    var animeDescShort: String {
        get {descShort ?? ""}
        set {descShort = newValue}
    }
    
    var animeMainImage: URL {
        // swiftlint:disable:next line_length
        mainImage ?? URL(fileURLWithPath: "https://res.cloudinary.com/emiya-consulting/image/upload/v1676688255/placeholder-image_qn4qjv.png")
    }
    
    var animeService: String {
        get {service ?? ""}
        set {service = newValue}
    }
    
    var animeDateCreated: Date {
        dateCreated ?? Date.now
    }
    
    var animeDateUpdated: Date {
        dateUpdated ?? Date.now
    }
    
    var animeTags: [Tag] {
        let result = tags?.allObjects as? [Tag] ?? []
        return result.sorted()
    }
    
    static var example: Anime {
        let controller = DataController(inMemory: true)
        let viewContext = controller.container.viewContext
        
        let anime = Anime(context: viewContext)
        anime.title = "Example Anime"
        anime.season = "1"
        anime.cour = "0"
        anime.genre = "CGDCT"
        anime.descShort = "Short description of example anime"
        anime.service = "Crunchyroll"
        anime.dateCreated = .now
        return anime
    }
}

extension Anime: Comparable {
    public static func < (lhs: Anime, rhs: Anime) -> Bool {
        let left = lhs.animeTitle.localizedLowercase
        let right = rhs.animeTitle.localizedLowercase
        
        if left == right {
            return lhs.animeDateCreated < rhs.animeDateCreated
        } else {
            return left < right
        }
    }
}
