//
//  ContentView.swift
//  SwiftDataProject
//
//  Created by Leo Chung on 1/11/24.
//

import SwiftUI
import SwiftData

// Filter starts with #Predicate<User> which means we're writing a predicate (test we are going to apply)
// The predicate gives us a single user instance to check -> in practice this will be called once for each user loaded by SwiftData, and we need to return true if that user should be included in the results
// Our test checks whether the user's name contains the capital letter R, if it does, the user will be included in the results, otherwise it won't

// #Predicate macro rewrites your code to be a series of tests it can apply on the database, which doesn't use Swift internally

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    // .localizedStandardContains is NOT case-sensitive
    @Query(filter: #Predicate<User> { user in
        user.name.localizedStandardContains("R") &&
        user.city == "London"
    }, sort: \User.name) var users: [User]
    
    // Note: .contains() is case-sensitive
    //    @Query(filter: #Predicate<User> { user in
    //        user.name.contains("R")
    //    }, sort: \User.name) var users: [User]
    // @Query(sort: \User.name) var users: [User]
    
    @State private var path = [User]()
    
    var body: some View {
        NavigationStack {
            List(users) { user in
                Text(user.name)
            }
            .navigationTitle("Users")
            .toolbar {
                Button("Add Samples", systemImage: "plus") {
                    try? modelContext.delete(model: User.self)
                    
                    let first = User(name: "Ed Sheeran", city: "London", joinDate: .now.addingTimeInterval(86400 * -10))
                    let second = User(name: "Rosa Diaz", city: "New York", joinDate: .now.addingTimeInterval(86400 * -5))
                    let third = User(name: "Roy Kent", city: "London", joinDate: .now.addingTimeInterval(86400 * 5))
                    let fourth = User(name: "Johnny English", city: "London", joinDate: .now.addingTimeInterval(86400 * 10))

                    modelContext.insert(first)
                    modelContext.insert(second)
                    modelContext.insert(third)
                    modelContext.insert(fourth)
                }
            }
        }

//        NavigationStack(path: $path) {
//            List(users) { user in
//                NavigationLink(value: user) {
//                    Text(user.name)
//                }
//            }
//            .navigationTitle("Users")
//            .navigationDestination(for: User.self) { user in
//                EditUserView(user: user)
//            }
//            .toolbar {
//                Button("Add User", systemImage: "plus") {
//                    let user = User(name: "", city: "", joinDate: .now)
//                    modelContext.insert(user)
//                    path = [user]
//                }
//            }
//        }
    }
}

#Preview {
    ContentView()
}
