//
//  LocationAddViewController.swift
//  onthemap
//
//  Created by Erick Medina on 7/9/18.
//  Copyright © 2018 Erick Medina. All rights reserved.
//

import UIKit

class LocationAddViewController: BaseViewController {

    @IBOutlet weak var mFindButton: UIButton!
    @IBOutlet weak var mWebsite: UITextField!
    @IBOutlet weak var mLocation: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func cancelAddLocation(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func findLocation(_ sender: Any) {
        //post
        guard let location = mLocation.text, !(mLocation.text?.isEmpty)! else {
            showAlert(nil, message: "Location must not be empty")
            return
        }
        
        guard let website = mWebsite.text, !(mWebsite.text?.isEmpty)! else {
            showAlert(nil, message: "Website must not be empty")
            return
        }
        
        var student = UDStudentLocation.StudentLocation()
        student.firstName = ""
        student.lastName = ""
        student.latitude = -1
        student.longitude = -1
        student.mediaURL = website
        student.uniqueKey = String(Date().timeIntervalSince1970)
        
        UDClient.sharedInstance().postStudentLocation(student){
            result, error in
            
        }
        
    }
    
}
