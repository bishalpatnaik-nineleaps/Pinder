//
//  ViewController.swift
//  pinder
//
//  Created by Nineleaps on 09/02/19.
//  Copyright © 2019 Nineleaps. All rights reserved.
//

import UIKit
import Alamofire
import Poi
import AlamofireObjectMapper
import SwiftKeychainWrapper

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardWillShow(notification: NSNotification) {
       // if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                let cg: CGFloat = 40
                self.view.frame.origin.y -= cg
            }
        //}
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }

    
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: "\(title)", message: "\(message)", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func loginPressed(sender: AnyObject) {
        txtPassword.text = "nineleaps"
        txtUsername.text = "JohnDoe"
        if(txtUsername.text == "" || txtPassword.text == "") {
            self.displayAlert(title: "Failure", message: "Too short password or username")
        }
        // With URLSession
       
        
        
        let parameters: [String: Any] = [ "username" : txtUsername.text!, "password" : txtPassword.text! ]
   
       
        apiCallWrapper.sharedInstance.requestForLoginDataWith("login", parameters: parameters, headers: nil) { (response) -> (Void) in

                                if response.response?.statusCode == 200 {
                                    let loginResponse = response.result.value
                                    let  retrivedToken = loginResponse?.response?.data?.rtoken!
                                    let _: Bool = KeychainWrapper.standard.set(retrivedToken!, forKey: "retrivedToken")
                                    _ = KeychainWrapper.standard.string(forKey: "retrivedToken")!
                                    self.performSegue(withIdentifier: "login_segue", sender: self)
                                } else if response.response?.statusCode == 404 {
                                    self.displayAlert(title: "Invalid credentials", message: "Either the username or the password is wrong")
                                } else if response.response?.statusCode == 400 {
                                    self.displayAlert(title: "Invalid User", message: "Please Enter again")
                                }
        }
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtUsername {
            textField.resignFirstResponder()
            txtPassword.becomeFirstResponder()
        }
//        else if textField == txtPassword {
//            txtPassword.resignFirstResponder()
//            loginPressed(sender: self)
//        }
//
        return true
    }
}
}
