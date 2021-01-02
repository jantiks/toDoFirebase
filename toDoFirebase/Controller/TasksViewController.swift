//
//  TasksViewController.swift
//  toDoFirebase
//
//  Created by Tigran on 12/29/20.
//  Copyright © 2020 Tigran. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate {
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tasks"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTask))
        
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
            _ in
            guard let textField = ac.textFields?.first , textField.text != "" else { return }
            
            //let task
            //taskref
            //
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        ac.addAction(save)
        ac.addAction(cancel)
        
        present(ac, animated: true) 
    }

}
