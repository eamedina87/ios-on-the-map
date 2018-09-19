//
//  ListViewController.swift
//  onthemap
//
//  Created by Erick Medina on 7/9/18.
//  Copyright © 2018 Erick Medina. All rights reserved.
//

import UIKit

class ListViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var mList: UITableView!
    var mLocations : [UDStudentLocation.StudentLocation] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getLocations()
    }

    
    @IBAction func refreshMap(_ sender: Any) {
        getApiLocations()
    }
    
    @IBAction func doLogout(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func getLocations(){
        if let locations = getCachedStudentLocations() {
            mLocations = locations
            mList.reloadData()
        } else {
            getApiLocations()
        }
    }
    
    func getApiLocations(){
        getApiStudentLocations(){
            locations in
            self.mLocations = locations
            self.mList.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let mLocation = mLocations[indexPath.row]
        let cell = mList.dequeueReusableCell(withIdentifier: "listCell") as! LocationTableViewCell
        cell.mName.text = mLocation.fullName()
        cell.mWebPage.text = mLocation.mediaURL
        return cell
    }
    
}
