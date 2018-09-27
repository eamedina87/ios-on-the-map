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
    @IBOutlet weak var mProgressIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func doLogin(_ sender: Any) {
        
        guard let email = mEmail.text, !email.isEmpty else {
            showAlert(nil, message: "Email should not be empty"){}
            return
        }
        guard let password = mPassword.text, !password.isEmpty else {
            showAlert(nil, message: "Password should not be empty"){}
            return
        }
        
        showIndicatorAndBlockUI()
        UDClient.sharedInstance().postSession(email, password: password){ (results, error) in
            guard error == nil else {
                performUIUpdatesOnMain {
                    self.hideIndicatorAndEnableUI()
                    self.showAlert("Login Error", message: "An error ocurred: \(String(describing: error?.userInfo[NSLocalizedDescriptionKey]))"){}
                }
                return
            }
            
            guard let results = results else {
                performUIUpdatesOnMain {
                    self.hideIndicatorAndEnableUI()
                }
                return
            }
            let session = String(describing: results)
            UserData.shared.sessionId = session
            print("Session: \(session)")
            performUIUpdatesOnMain {
                self.hideIndicatorAndEnableUI()
                self.clearTextFields()
                let mainVC : UIViewController = (self.storyboard?.instantiateViewController(withIdentifier: "tabBar"))!
                self.present(mainVC, animated: true, completion: nil)
            }
            
        }
    }
    
    @IBAction func doSignUp(_ sender: Any) {
        let url : URL = URL(string: "https://www.udacity.com")!
        goToUrl(url: url)
    }
    
    func showIndicatorAndBlockUI(){
        mProgressIndicator.startAnimating()
        setUIEnabled(value:false)
    }
    
    func hideIndicatorAndEnableUI(){
        mProgressIndicator.stopAnimating()
        setUIEnabled(value:true)
    }
    
    func clearTextFields(){
        mEmail.text = ""
        mPassword.text = ""
    }
    
    func setUIEnabled(value:Bool){
        mLoginButton.isEnabled = value
        mSIgnUpButton.isEnabled = value
        mEmail.isEnabled = value
        mPassword.isEnabled = value
    }
}
