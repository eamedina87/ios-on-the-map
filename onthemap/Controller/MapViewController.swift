//
//  MapViewController.swift
//  onthemap
//
//  Created by Erick Medina on 7/9/18.
//  Copyright © 2018 Erick Medina. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: BaseViewController {

    @IBOutlet weak var mRefreshButton: UIBarButtonItem!
    @IBOutlet weak var mAddButton: UIBarButtonItem!
    @IBOutlet weak var mLogoutButton: UIBarButtonItem!
    @IBOutlet weak var mMap: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func refreshList(_ sender: Any) {
        
    }
    
    @IBAction func doLogout(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
