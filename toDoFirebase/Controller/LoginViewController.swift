//
//  ViewController.swift
//  toDoFirebase
//
//  Created by Tigran on 12/29/20.
//  Copyright © 2020 Tigran. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet var warnLabel: UILabel!
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(kdDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kdDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
        warnLabel.isHidden = true
    }
    @objc func kdDidShow(notification: Notification) {
        guard let userInfo = notification.userInfo else { return }
        let kbFrameSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        (view as! UIScrollView).isScrollEnabled = true
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height + kbFrameSize.height)
    }
    
    @objc func kdDidHide() {
        (self.view as! UIScrollView).contentSize = CGSize(width: self.view.bounds.size.width, height: self.view.bounds.size.height)
    }

    @IBAction func loginTapped(_ sender: Any) {
        print("login tapped")
    }
    
    @IBAction func registerTapped(_ sender: Any) {
    }
    
    
}

