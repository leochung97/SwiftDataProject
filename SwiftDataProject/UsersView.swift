//
//  UsersView.swift
//  SwiftDataProject
//
//  Created by Leo Chung on 1/12/24.
//

import SwiftUI
import SwiftData

struct UsersView: View {
    init(minimumJoinDate: Date, sortOrder: [SortDescriptor<User>]) {
        _users = Query(filter: #Predicate<User> { user in
            user.joinDate >= minimumJoinDate
        }, sort: sortOrder)
    }
    
//    init(minimumJoinDate: Date) {
//        // The underscore is Swift's way of getting access to the query -> we are not trying to change the User array -> we are trying to change the query that produces the array
//        _users = Query(filter: #Predicate<User> { user in
//            user.joinDate >= minimumJoinDate
//        }, sort: \User.name)
//    }
//    
    @Query var users: [User]
    
    var body: some View {
        List(users) { user in
            Text(user.name)
        }
    }
}

#Preview {
    UsersView(minimumJoinDate: .now, sortOrder: [SortDescriptor(\User.name)])
        .modelContainer(for: User.self)
}
