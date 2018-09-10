//
//  UDSession.swift
//  onthemap
//
//  Created by Erick Medina on 9/9/18.
//  Copyright © 2018 Erick Medina. All rights reserved.
//

import Foundation

struct UDSession: Codable {
/*{
    "account":{
    "registered":true,
    "key":"3903878747"
    },
    "session":{
    "id":"1457628510Sc18f2ad4cd3fb317fb8e028488694088",
    "expiration":"2015-05-10T16:48:30.760460Z"
    }
    }*/
    struct Account:Codable {
        let registered : Bool
        let key : Int32
    }
    
    struct Session:Codable {
        let id : String
        let expiration : String
    }
    
    let account : Account
    let session : Session
    
}
