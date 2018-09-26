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
        guard self.firstName == nil, self.lastName == nil else{
            return "\(String(describing: self.firstName!)) \(String(describing: self.lastName!))"
        }
        guard self.firstName == nil else {
            return "\(String(describing: self.firstName!))"
        }
        return ""
    }
    
    func coordinate()->CLLocationCoordinate2D{
        guard self.latitude == nil, self.longitude == nil else {
            return CLLocationCoordinate2DMake(self.latitude!, self.longitude!)
        }
        return CLLocationCoordinate2DMake(0, 0)
    }
    
}



