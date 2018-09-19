//
//  MapViewController.swift
//  onthemap
//
//  Created by Erick Medina on 7/9/18.
//  Copyright © 2018 Erick Medina. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: BaseViewController, MKMapViewDelegate {

    @IBOutlet weak var mRefreshButton: UIBarButtonItem!
    @IBOutlet weak var mAddButton: UIBarButtonItem!
    @IBOutlet weak var mLogoutButton: UIBarButtonItem!
    @IBOutlet weak var mMap: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mMap.delegate = self
        mMap.isZoomEnabled = true
    }
    
    @IBAction func refreshList(_ sender: Any) {
        getApiLocations()
    }
    
    @IBAction func doLogout(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        getLocations()
    }
    
    func getLocations(){
        if let locations = getCachedStudentLocations() {
            addLocationsToMap(locations: locations)
        } else {
            getApiLocations()
        }
    }
    
    func getApiLocations(){
        getApiStudentLocations(){
            locations in
            self.addLocationsToMap(locations: locations)
        }
    }
   
    func addLocationsToMap(locations: [UDStudentLocation.StudentLocation]){
        //todo remove previous annotations
        for location in locations{
            self.addLocationToMap(location: location)
        }
    }
    
    func addLocationToMap(location: UDStudentLocation.StudentLocation){
        performUIUpdatesOnMain {
            let annotation = MKPointAnnotation()
            annotation.coordinate = location.coordinate()
            self.mMap.addAnnotation(annotation)
        }
    }
    
    
}


