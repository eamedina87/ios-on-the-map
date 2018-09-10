//
//  ListViewController.swift
//  onthemap
//
//  Created by Erick Medina on 7/9/18.
//  Copyright © 2018 Erick Medina. All rights reserved.
//

import UIKit

class ListViewController: BaseViewController {//, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var mList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func addLocation(_ sender: Any) {
        
    }
    
    @IBAction func refreshMap(_ sender: Any) {
        
    }
    
    @IBAction func doLogout(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    /*
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    }*/
    
}
