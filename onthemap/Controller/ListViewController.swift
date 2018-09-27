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
        mList.dataSource = self
        mList.delegate = self
        getLocations()
    }

    
    @IBAction func refreshMap(_ sender: Any) {
        getApiLocations()
    }
    
    @IBAction func doLogout(_ sender: Any) {
        doApiLogout {
            data, error in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func getLocations(){
        if (getCachedStudentLocations()?.count)! > 0{
            mLocations = getCachedStudentLocations()!
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mLocation = mLocations[indexPath.row]
        if let mediaURL = mLocation.mediaURL{
            let url : URL = URL(string: mediaURL)!
            goToUrl(url: url)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
