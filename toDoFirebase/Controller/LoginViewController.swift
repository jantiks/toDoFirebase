//
//  ViewController.swift
//  toDoFirebase
//
//  Created by Tigran on 12/29/20.
//  Copyright © 2020 Tigran. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet var warnLabel: UILabel!
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(kdDidShow), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kdDidHide), name: UIResponder.keyboardDidHideNotification, object: nil)
        warnLabel.alpha = 0
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
    
    func displayWarningLabel(withText text: String) {
        warnLabel.text = text
        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: [.curveEaseInOut], animations: { [weak self] in
            self?.warnLabel.alpha = 1
        }) { [weak self] complete in
            self?.warnLabel.alpha = 0
            
        }
    }

    @IBAction func loginTapped(_ sender: Any) {

        guard let email = emailTF.text , let password = passwordTF.text , !email.isEmpty, !password.isEmpty else {
            displayWarningLabel(withText: "Info is incorrect")
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if error != nil {
                self?.displayWarningLabel(withText: "Error occured")
                return
            }
            if authResult?.user != nil {
                self?.performSegue(withIdentifier: "tasksSegue", sender: nil)
                return
            } else {
                self?.displayWarningLabel(withText: "User doesn't exist")
            }
        }
    }
    
    @IBAction func registerTapped(_ sender: Any) {
        guard let email = emailTF.text , let password = passwordTF.text , !email.isEmpty, !password.isEmpty else {
            displayWarningLabel(withText: "Info is incorrect")
            return
        }
        Auth.auth().createUser(withEmail: email, password: password) {
            [weak self] authResult, error in
            if error == nil {
                if authResult?.user != nil {
                    self?.performSegue(withIdentifier: "tasksSegue", sender: nil)
                }
            }
        }
    }
    
    
}

