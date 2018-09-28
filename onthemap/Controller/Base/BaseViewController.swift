//
//  BaseViewController.swift
//  onthemap
//
//  Created by Erick Medina on 8/9/18.
//  Copyright © 2018 Erick Medina. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAlert(_ title:String?, message:String, completionHandler: @escaping (()->Void)){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel){ action in
            alertController.dismiss(animated: true, completion: completionHandler)
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func getApiStudentLocations(completionHandler: @escaping (_ locations: [UDStudentLocation.StudentLocation]) -> Void){
        UDClient.sharedInstance().getStudentLocations(){
            locations, error in
            
            guard error == nil else {
                performUIUpdatesOnMain {
                    self.showAlert("Student Locations Error", message: "An error ocurred: \(String(describing: error?.userInfo[NSLocalizedDescriptionKey]))"){}
                }
                return
            }
            
            guard let locations = locations else {
                self.showAlert("Student Locations Error", message: "An error ocurred obtaining the locations. Please retry!"){}
                return
            }
            
            print("Locations: \(locations.count)")
            UserData.shared.locations = locations
            completionHandler(locations)
        }
    }
    
    func doApiLogout(completionHandler: @escaping ((Data?, NSError?)->Void)){
        UDClient.sharedInstance().deleteSession(completionHandlerForDELETE: completionHandler)
    }
    
    func getCachedStudentLocations() -> [UDStudentLocation.StudentLocation]? {
        return UserData.shared.locations
    }
    
    func goToUrl(url:URL){
        if (UIApplication.shared.canOpenURL(url)){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    

}
