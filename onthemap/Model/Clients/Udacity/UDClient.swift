//
//  UDClient.swift
//  onthemap
//
//  Created by Erick Medina on 7/9/18.
//  Copyright © 2018 Erick Medina. All rights reserved.
//

import UIKit
import Foundation

class UDClient: BaseClient {
    
    class func sharedInstance() -> UDClient {
        struct Singleton {
            static var sharedInstance = UDClient()
        }
        return Singleton.sharedInstance
    }
    
    // MARK: GET Convenience Methods
    
    func getStudentLocations(completionHandlerForPostSession: @escaping (_ result: [UDStudentLocation.StudentLocation]?, _ error: NSError?) -> Void){
        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
        var parameters = [String:AnyObject]()
        parameters[UDClient.ParameterKeys.Limit] = UDClient.Constants.ParseApiLimit as AnyObject?
        /* 2. Make the request */
        let task = taskForGETMethod("", isForParse: true, parameters: parameters){
            result, error in
            
            func returnError(){
                completionHandlerForPostSession(nil, NSError(domain: "getStudentLocation parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse getStudentLocation"]))
            }
            
            guard (error == nil) else {
                completionHandlerForPostSession(nil, error)
                return
            }
            
            guard let data = result else {
                returnError()
                return
            }
            
            print(data)
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(UDStudentLocation.self, from: data)
                if let returnData : [UDStudentLocation.StudentLocation] = response.results {
                    completionHandlerForPostSession(returnData, nil)
                } else {
                    returnError()
                }
            } catch{
                returnError()
            }
        }
    }
    
    
    // MARK: POST Convenience Methods
    func postSession(_ username: String, password: String, completionHandlerForPostSession: @escaping (_ result: String?, _ error: NSError?) -> Void) {
        
        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
        let parameters = [String:AnyObject]()
        
        let jsonBody = "{\"udacity\": {\"\(JsonBody.username)\": \"\(username)\", \"\(JsonBody.password)\": \"\(password)\"}}"
        /* 2. Make the request */
        let task = taskForPOSTMethod(false, parameters: parameters, jsonBody: jsonBody){
            result, error in
            
            func returnError(){
                completionHandlerForPostSession(nil, NSError(domain: "postToSession parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse postToSession"]))
            }
            
            guard (error == nil) else {
                completionHandlerForPostSession(nil, error)
                return
            }
            
            guard let data = result else {
                returnError()
                return
            }
            
            print(data)
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(UDSession.self, from: data)
                if let returnData : String = response.session.id {
                    completionHandlerForPostSession(returnData, nil)
                } else {
                    returnError()
                }
            } catch{
                returnError()
            }
        }
    }
    
    func postStudentLocation(_ student: UDStudentLocation.StudentLocation, completionHandlerForPostStudentLocation: @escaping (_ result: String?, _ error: NSError?) -> Void) {
        
        /* 1. Specify parameters, method (if has {key}), and HTTP body (if POST) */
        let parameters = [String:String]()
        
        //\"uniqueKey\": \"1234\"
        let jsonBody = "{\"\(JsonBody.firstName)\": \"\(student.firstName)\", \"\(JsonBody.lastName)\": \"\(student.lastName)\",\"\(JsonBody.mapString)\": \"\(student.mapString)\", \"\(JsonBody.mediaUrl)\": \"\(student.mediaURL)\",\"\(JsonBody.latitude)\": \(student.latitude), \"\(JsonBody.longitude)\": \(student.longitude)}"//.data(using: .utf8).
        
        /* 2. Make the request */
        let task = taskForPOSTMethod(true, parameters: parameters as [String:AnyObject], jsonBody: jsonBody){
            (data, error) in
            
            func returnError(error:NSError? = nil){
                if let error = error{
                    completionHandlerForPostStudentLocation(nil, error)
                } else {
                completionHandlerForPostStudentLocation(nil, NSError(domain: "postToStudentLocation parsing", code: 0, userInfo: [NSLocalizedDescriptionKey: "Could not parse postToStudentLocation"]))
                }
            }
            
            /* 3. Send the desired value(s) to completion handler */
            
            guard (error == nil) else {
                returnError(error: error)
                return
            }
            
            guard let data = data else {
                returnError()
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let response = try decoder.decode(UDResponse.self, from: data)
                if let returnData : String = response.objectId{
                    completionHandlerForPostStudentLocation(returnData, nil)
                } else {
                    returnError()
                }
            } catch {
                returnError()
            }
        }
    }
    
    //MARK: Helper
    static func udacityURLFromParameters(_ parameters: [String:AnyObject], withPathExtension: String? = nil, isForParse:Bool = false) -> URL {
        var components = URLComponents()
        components.scheme = ( isForParse ? UDClient.Constants.ParseApiScheme : UDClient.Constants.SessionApiScheme)
        components.host = ( isForParse ? UDClient.Constants.ParseApiHost : UDClient.Constants.SessionApiHost)
        components.path = ( isForParse ? UDClient.Constants.ParseApiPath + (withPathExtension ?? ""): UDClient.Constants.SessionApiPath)
        if (isForParse){
            components.queryItems = [URLQueryItem]()
            for (key, value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                components.queryItems!.append(queryItem)
            }
        }
        return components.url!
    }

}
