//
//  Task.swift
//  toDoFirebase
//
//  Created by Tigran on 1/2/21.
//  Copyright © 2021 Tigran. All rights reserved.
//

import Foundation
import Firebase

struct Task {
    let title: String
    let userId: String
    let ref: Firebase.DatabaseReference?
    var completed: Bool = false
    
    init(title: String, userId: String) {
        self.title = title
        self.userId = userId
        self.ref = nil
    }
    init(snapShot: Firebase.DataSnapshot) {
        let snapShotValue = snapShot.value as! [String: AnyObject]
        title = snapShotValue["title"] as! String
        userId = snapShotValue["userId"] as! String
        completed = snapShotValue["completed"] as! Bool
        ref = snapShot.ref
    }
}
