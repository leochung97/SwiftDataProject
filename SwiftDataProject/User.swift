//
//  User.swift
//  SwiftDataProject
//
//  Created by Leo Chung on 1/11/24.
//

import Foundation
import SwiftData

@Model
class User {
    var name: String = "Anonymous"
    var city: String = "Unknown"
    var joinDate: Date = Date.now
    @Relationship(deleteRule: .cascade) var jobs: [Job]? = [Job]()
    // var jobs = [Job]()
    
    init(name: String, city: String, joinDate: Date) {
        self.name = name
        self.city = city
        self.joinDate = joinDate
    }
}

// Note: adding a new relational model to User -> SwiftData will silently add jobs property to all of its existing users, giving them an empty array by default
// This is called  amigration: when we add or delete properties in our models
// You can also do custom migrations to handle bigger model changes

/*
 Note: if you delete a user, the jobs data will remain intact unless you use a @Relationship macro, providing it with a delete rule that describes how Job objects should be handled when their owning User is deleted
 The default delete rule is called .nullify, which means the owner property of each Job object gets set to nil, marking that they have no owner
 You can use .cascade, which means deleting a User should automatically delete all of their Job objects -> it's called cascade because the delete keeps going for all related objects
*/

/*
 For iCloud capability -> purchase a paid developer program account on Apple
 Note: SwiftData with iCloud has a requirement -> all properties must be optional or have default values, and all relationships must be optional
*/
@Model
class Job {
    var name: String = "None"
    var priority: Int = 1
    var owner: User?

    init(name: String, priority: Int, owner: User? = nil) {
        self.name = name
        self.priority = priority
        self.owner = owner
    }
}
