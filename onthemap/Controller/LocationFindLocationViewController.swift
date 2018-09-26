//
//  LocationFindLocationViewController.swift
//  onthemap
//
//  Created by Erick Medina on 26/9/18.
//  Copyright © 2018 Erick Medina. All rights reserved.
//

import UIKit
import MapKit

class LocationFindLocationViewController: BaseViewController {
    @IBOutlet weak var mFindButton: UIButton!
    
    var mStudent : UDStudentLocation.StudentLocation? = nil
    var mParentViewController : LocationAddViewController? = nil
    
    @IBOutlet weak var mProgressIndicator: UIActivityIndicatorView!
    @IBOutlet weak var mMap: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let mStudent = mStudent, mStudent.latitude != nil, mStudent.longitude != nil {
            let center = CLLocationCoordinate2DMake(mStudent.latitude!, mStudent.longitude!)
            let region = MKCoordinateRegionMakeWithDistance(center, 4000, 4000)
            let annotation = MKPointAnnotation()
            annotation.coordinate = center
            mMap.addAnnotation(annotation)
            mMap.setRegion(region, animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }

    @IBAction func finishLocation(_ sender: Any) {
        if let mStudent = mStudent{
            self.showIndicatorAndBlockUI()
            UDClient.sharedInstance().postStudentLocation(mStudent){
             result, error in
                guard error == nil else {
                    performUIUpdatesOnMain {
                        self.hideIndicatorAndEnableUI()
                        self.showAlert("Post New Location", message: "An error ocurred: \(error?.domain)"){}
                    }
                    return
                }
                if result != nil {
                    performUIUpdatesOnMain {
                        self.hideIndicatorAndEnableUI()
                        let alertController = UIAlertController(title: "Post New Location", message: "Student posted successfully", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "OK", style: .cancel){ action in
                            alertController.dismiss(animated: true)
                            self.navigationController?.dismiss(animated: true, completion: nil)
                        }
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                        
                    }
                } else {
                    performUIUpdatesOnMain {
                        self.hideIndicatorAndEnableUI()
                        self.showAlert("Post New Location", message: "An error ocurred "){}
                    }
                }
             }
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
    }
    

   

}
