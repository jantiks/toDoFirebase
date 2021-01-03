//
//  TasksViewController.swift
//  toDoFirebase
//
//  Created by Tigran on 12/29/20.
//  Copyright © 2020 Tigran. All rights reserved.
//

import UIKit
import Firebase

class TasksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate {
    var user: User!
    var ref: DatabaseReference!
    var tasks = [Task]()
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tasks"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(signOutTapped))
        
        guard let currentUser = Auth.auth().currentUser else { return }
        user = User(user: currentUser)
        ref = Database.database().reference(withPath: "users").child(String(user.uid)).child("tasks")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .clear
        cell.textLabel?.text = "this is cell number \(indexPath.row)"
        return cell
    }
    
    @objc func addTask() {
        let ac =  UIAlertController(title: "New Task", message: "Add Task", preferredStyle: .alert)
        ac.addTextField()
        let save = UIAlertAction(title: "Save", style: .default) {
            [weak self] _ in
            guard let superSelf = self else { return }
            guard let textField = ac.textFields?.first , textField.text != "" else { return }
            let task = Task(title: textField.text!, userId: superSelf.user.uid)
            let taskRef = superSelf.ref.child(task.title.lowercased())
            taskRef.setValue(task.convertToDictionary())
            
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        ac.addAction(save)
        ac.addAction(cancel)
        
        present(ac, animated: true) 
    }
    
    @objc func signOutTapped() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
        dismiss(animated: true, completion: nil)
    }

}
