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
            print("Session: \(String(describing: results))")
            performUIUpdatesOnMain {
                self.hideIndicatorAndEnableUI()
                let mainVC : UIViewController = (self.storyboard?.instantiateViewController(withIdentifier: "tabBar"))!
                self.present(mainVC, animated: true, completion: nil)
            }
            
        }
    }
    
    @IBAction func doSignUp(_ sender: Any) {
        let url : URL = URL(string: "https://www.udacity.com")!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    func showIndicatorAndBlockUI(){
        mProgressIndicator.startAnimating()
        setUIEnabled(value:false)
    }
    
    func hideIndicatorAndEnableUI(){
        mProgressIndicator.stopAnimating()
        setUIEnabled(value:true)
    }
    
    func setUIEnabled(value:Bool){
        mLoginButton.isEnabled = value
        mSIgnUpButton.isEnabled = value
        mEmail.isEnabled = value
        mPassword.isEnabled = value
    }
}
