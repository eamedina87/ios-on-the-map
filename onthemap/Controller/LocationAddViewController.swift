//
//  LocationAddViewController.swift
//  onthemap
//
//  Created by Erick Medina on 7/9/18.
//  Copyright © 2018 Erick Medina. All rights reserved.
//

import UIKit

class LocationAddViewController: UIViewController {

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
        
    }
    
}
