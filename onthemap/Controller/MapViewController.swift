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
        doApiLogout {
            data, error in
          self.dismiss(animated: true, completion: nil)
        }
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        getLocations()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(calloutTapped(_:)))
        view.addGestureRecognizer(gesture)
    }
    
    @objc
    func calloutTapped(_ sender:UITapGestureRecognizer) {
        if let mediaURL = (sender.view as? MKAnnotationView)?.annotation?.subtitle! {
            let url : URL = URL(string: mediaURL)!
            goToUrl(url: url)
        }
        
    }
    
    func getLocations(){
        if (getCachedStudentLocations()?.count)! > 0 {
            addLocationsToMap(locations: getCachedStudentLocations()!)
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
        mMap.removeAnnotations(mMap.annotations)
        for location in locations{
            self.addLocationToMap(location: location)
        }
    }
    
    func addLocationToMap(location: UDStudentLocation.StudentLocation){
        performUIUpdatesOnMain {
            let annotation = MKPointAnnotation()
            annotation.title = (location.firstName == nil ? "" : "\(location.firstName!) ") + (location.lastName == nil ? "" : "\(location.lastName!) ")
            annotation.subtitle = location.mediaURL
            annotation.coordinate = location.coordinate()
            self.mMap.addAnnotation(annotation)
        }
    }
    
    
}


