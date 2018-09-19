//
//  UDStudentLocation.swift
//  onthemap
//
//  Created by Erick Medina on 7/9/18.
//  Copyright © 2018 Erick Medina. All rights reserved.
//

import Foundation

struct UDStudentLocation: Codable {
    
    let results : [StudentLocation]
    
    struct StudentLocation : Codable {
        
/*"createdAt": "2015-02-25T01:10:38.103Z",
 "firstName": "Jarrod",
 "lastName": "Parkes",
 "latitude": 34.7303688,
 "longitude": -86.5861037,
 "mapString": "Huntsville, Alabama ",
 "mediaURL": "https://www.linkedin.com/in/jarrodparkes",
 "objectId": "JhOtcRkxsh",
 "uniqueKey": "996618664",
 "updatedAt": "2015-03-09T22:04:50.315Z"*/
        
        var createdAt : String
        var objectId : String
        var uniqueKey : String?
        var firstName : String
        var lastName : String
        var mapString : String?
        var mediaUrl : String
        var latitude : Double
        var longitude : Double
        
        init() {
            self.createdAt = ""
            self.objectId = ""
            self.uniqueKey = ""
            self.firstName = ""
            self.lastName = ""
            self.mapString = ""
            self.mediaUrl = ""
            self.latitude = -1
            self.longitude = -1
        }
        
    }
    
    
    
}
