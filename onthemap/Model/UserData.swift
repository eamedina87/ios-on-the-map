//
//  UserData.swift
//  onthemap
//
//  Created by Erick Medina on 27/9/18.
//  Copyright © 2018 Erick Medina. All rights reserved.
//

import Foundation

struct UserData {
    var locations = [UDStudentLocation.StudentLocation]()
    var sessionId : String?
    static var shared = UserData()
}
