//
//  UDConstants.swift
//  onthemap
//
//  Created by Erick Medina on 7/9/18.
//  Copyright © 2018 Erick Medina. All rights reserved.
//

import UIKit

extension UDClient {

    struct Constants {
        
        // MARK: Keys
        static let ParseAppId = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        static let ParseApiKey = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
        
        // MARK: URLs
        static let SessionApiScheme = "https"
        static let SessionApiHost = "www.udacity.com"
        static let SessionApiPath = "/api/session"
        
        //https://parse.udacity.com/parse/classes/StudentLocation
        //https://parse.udacity.com/parse/classes/StudentLocation/<objectId>
        static let ParseApiScheme = "https"
        static let ParseApiHost = "parse.udacity.com"
        static let ParseApiPath = "/parse/classes/StudentLocation"
        
        static let ParseApiLimit = "10"
        
    }
    
    struct ParameterKeys {
        static let ApiKey = "api_key"
        static let SessionID = "session_id"
        static let RequestToken = "request_token"
        static let Query = "query"
        static let Limit = "limit"
    }
    
    //MARK: JSON REQUEST BODY
    struct JsonBody{
        //MARK: JSON SESSION
        static let udacity = "udacity"
        static let username = "username"
        static let password = "password"
        //MARK: JSON STUDENT LOCATION
        static let objectId = "objectId"
        static let uniqueKey = "uniqueKey"
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let mapString = "mapString"
        static let mediaUrl = "mediaUrl"
        static let latitude = "latitude"
        static let longitude = "longitude"
    }
    
    //MARK: JSON RESPONSE
    struct JsonResponse {
        //MARK: JSON SESSION
        static let account = "account"
        static let registered = "registered"
        static let key = "key"
        static let session = "session"
        static let id = "id"
        static let expiration = "expiration"
        //MARK: JSON STUDENT
        static let createdAt = "createdAt"
        static let updatedAt = "updatedAt"
        static let objectId = "objectId"
        static let results = "results"
        static let uniqueKey = "uniqueKey"
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let mapString = "mapString"
        static let mediaUrl = "mediaUrl"
        static let latitude = "latitude"
        static let longitude = "longitude"
    }
    
    
}
