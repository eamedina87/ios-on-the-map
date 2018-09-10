//
//  UDStudentLocation.swift
//  onthemap
//
//  Created by Erick Medina on 7/9/18.
//  Copyright © 2018 Erick Medina. All rights reserved.
//

import Foundation

struct UDStudentLocation: Codable {
    
    //override
    init() {
        self.objectId = ""
        self.uniqueKey = ""
        self.firstName = ""
        self.lastName = ""
        self.mapString = ""
        self.mediaUrl = ""
        self.latitude = -1
        self.longitude = -1
    }
    
    var objectId : String
    var uniqueKey : String?
    var firstName : String
    var lastName : String
    var mapString : String?
    var mediaUrl : String
    var latitude : Double
    var longitude : Double
    
}
