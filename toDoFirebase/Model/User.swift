//
//  User.swift
//  toDoFirebase
//
//  Created by Tigran on 1/2/21.
//  Copyright © 2021 Tigran. All rights reserved.
//

import Foundation
import Firebase
struct User {
    let uid: String
    let email: String
    
    init(user: Firebase.User) {
        self.uid = user.uid
        self.email = user.email!
    }
}
