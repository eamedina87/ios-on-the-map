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
        
/*
         "results":[{"objectId":"zHkIrIWrOf","uniqueKey":"10853850995","firstName":"Rodrigo","lastName":"Nobrega","mapString":"SÃ£o Paulo","mediaURL":"http://www.google.com","latitude":-23.5473991,"longitude":-46.6367427,"createdAt":"2018-09-19T01:17:17.013Z","updatedAt":"2018-09-19T01:17:17.013Z"},{"objectId":"V17vn7tPmb","uniqueKey":"10853850995","firstName":"Rodrigo","lastName":"Nobrega","mapString":"SÃ£o Paulo","mediaURL":"http://www.google.com","latitude":-23.5473991,"longitude":-46.6367427,"createdAt":"2018-0
         */
        
        var objectId : String?
        var uniqueKey : String?
        var firstName : String?
        var lastName : String?
        var mapString : String?
        var mediaURL : String?
        var latitude : Double?
        var longitude : Double?
        var createdAt : String?
        var updatedAt : String?
        
        init() {
            self.createdAt = ""
            self.objectId = ""
            self.uniqueKey = ""
            self.firstName = ""
            self.lastName = ""
            self.mapString = ""
            self.mediaURL = ""
            self.latitude = -1
            self.longitude = -1
            self.updatedAt = ""
        }
        
    }
    
    
    
}
