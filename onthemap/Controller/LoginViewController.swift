//
//  LoginViewController.swift
//  onthemap
//
//  Created by Erick Medina on 7/9/18.
//  Copyright © 2018 Erick Medina. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    @IBOutlet weak var mEmail: UITextField!
    @IBOutlet weak var mPassword: UITextField!
    @IBOutlet weak var mLoginButton: UIButton!
    @IBOutlet weak var mSIgnUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func doLogin(_ sender: Any) {
        
        guard let email = mEmail.text, !email.isEmpty else {
            showAlert(nil, message: "Email should not be empty")
            return
        }
        guard let password = mPassword.text, !password.isEmpty else {
            showAlert(nil, message: "Password should not be empty")
            return
        }
        
        UDClient.sharedInstance().postSession(email, password: password){ (results, error) in
            guard error == nil else {
                performUIUpdatesOnMain {
                    self.showAlert("Login Error", message: "An error ocurred: \(String(describing: error?.userInfo[NSLocalizedDescriptionKey]))")
                }
                return
            }
            
            guard let results = results else {
                return
            }
            print("Session: \(String(describing: results))")
            performUIUpdatesOnMain {
                let mainVC : UIViewController = (self.storyboard?.instantiateViewController(withIdentifier: "tabBar"))!
                self.present(mainVC, animated: true, completion: nil)
            }
            
        }
    }
    
    @IBAction func doSignUp(_ sender: Any) {
        
    }
    

}
