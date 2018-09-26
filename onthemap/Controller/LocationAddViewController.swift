//
//  LocationAddViewController.swift
//  onthemap
//
//  Created by Erick Medina on 7/9/18.
//  Copyright © 2018 Erick Medina. All rights reserved.
//

import UIKit
import MapKit

class LocationAddViewController: BaseViewController {

    @IBOutlet weak var mFindButton: UIButton!
    @IBOutlet weak var mWebsite: UITextField!
    @IBOutlet weak var mLocation: UITextField!
    @IBOutlet weak var mProgressIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func cancelAddLocation(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func findLocation(_ sender: Any) {
        //post
        guard let location = mLocation.text, !(mLocation.text?.isEmpty)! else {
            showAlert(nil, message: "Location must not be empty"){}
            return
        }
        
        guard let website = mWebsite.text, !(mWebsite.text?.isEmpty)! else {
            showAlert(nil, message: "Website must not be empty"){}
            return
        }
        
        let geocoder = CLGeocoder()
        showIndicatorAndBlockUI()
        geocoder.geocodeAddressString(location){
            (placemarks, error) in
            guard (error==nil) else {
                performUIUpdatesOnMain {
                    self.hideIndicatorAndEnableUI()
                    self.showAlert("Geocoding", message: "An error ocurred obtaining the location. Please retry!"){}
                }
                return
            }
            
            guard let placemarks = placemarks else {
                performUIUpdatesOnMain {
                    self.hideIndicatorAndEnableUI()
                    self.showAlert("Geocoding", message: "An error ocurred obtaining the location. Please retry!"){}
                }
                return
            }
            
            if (placemarks.count == 0){
                performUIUpdatesOnMain {
                    self.hideIndicatorAndEnableUI()
                    self.showAlert("Geocoding", message: "No locations found for the user input."){}
                }
                return
            } else {
                performUIUpdatesOnMain {
                    self.hideIndicatorAndEnableUI()
                }
                let placemark = placemarks[0]
                 var student = UDStudentLocation.StudentLocation()
                 student.firstName = "Udacity"
                 student.lastName = "Test"
                 student.latitude = placemark.location?.coordinate.latitude
                 student.longitude =  placemark.location?.coordinate.longitude
                 student.mediaURL = website
                 student.uniqueKey = String(Date().timeIntervalSince1970)
                
                self.performSegue(withIdentifier: "findLocation", sender: student)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier=="findLocation"){
            let destinationVC = segue.destination as! LocationFindLocationViewController
            destinationVC.mStudent = sender as! UDStudentLocation.StudentLocation
            destinationVC.mParentViewController = self
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
        mFindButton.isEnabled = value
        mLocation.isEnabled = value
        mWebsite.isEnabled = value
    }
    
}
