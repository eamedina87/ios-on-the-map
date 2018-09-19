//
//  Extension.swift
//  onthemap
//
//  Created by Erick Medina on 8/9/18.
//  Copyright © 2018 Erick Medina. All rights reserved.
//

import Foundation
import MapKit

extension Data {
    func toString() -> String? {
        return String(data: self, encoding: .utf8)
    }
}

extension NSMutableURLRequest {
    func log() {
        print("\(httpMethod ) \(self)")
        print("BODY \n \(String(describing: httpBody?.toString()))")
        print("HEADERS \n \(String(describing: allHTTPHeaderFields))")
    }
}

extension UDStudentLocation.StudentLocation{

    func fullName()->String{
        return "\(self.firstName) \(self.lastName)"
    }
    
    func coordinate()->CLLocationCoordinate2D{
        return CLLocationCoordinate2DMake(self.latitude, self.longitude)
    }
    
}



