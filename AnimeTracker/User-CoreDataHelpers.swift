//
//  User-CoreDataHelpers.swift
//  AnimeTracker
//
//  Created by Rob Ranf on 2/17/23.
//

import Foundation

extension User {
    var userUserName: String {
        get { userName ?? ""}
        set { userName = newValue }
    }
    
    var userFirstName: String {
        get { firstName ?? "" }
        set { firstName = newValue }
    }
    
    var userLastName: String {
        get { lastName ?? "" }
        set { lastName = newValue }
    }
    
    var userEmail: String {
        get { email ?? "" }
        set { email = newValue }
    }
    
    var userMobile: String {
        get { mobile ?? "" }
        set { mobile = newValue }
    }
    
    var userProfileImage: URL {
        // swiftlint:disable:next line_length
        profileImage ?? URL(fileURLWithPath: "https://res.cloudinary.com/emiya-consulting/image/upload/v1676688255/placeholder-image_qn4qjv.png")
    }
    
    var userDateCreated: Date {
        dateCreated ?? Date.now
    }
    
    var userDateUpdated: Date {
        dateUpdated ?? Date.now
    }
    
    static var example: User {
        let controller = DataController(inMemory: true)
        let viewContext = controller.container.viewContext
        
        let user = User(context: viewContext)
        user.id = UUID()
        user.userName = "Example User"
        return user
    }
}

extension User: Comparable {
    public static func < (lhs: User, rhs: User) -> Bool {
        let left = lhs.userUserName.localizedLowercase
        let right = rhs.userUserName.localizedLowercase
        
        if left == right {
            return lhs.userDateCreated < rhs.userDateCreated
        } else {
            return left < right
        }
    }
}
