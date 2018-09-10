//
//  BaseClient.swift
//  onthemap
//
//  Created by Erick Medina on 7/9/18.
//  Copyright © 2018 Erick Medina. All rights reserved.
//

import Foundation

class BaseClient: NSObject {

    var session = URLSession.shared
    
    // MARK: GET
    func taskForGETMethod(_ method: String, isForParse:Bool, parameters: [String:AnyObject], completionHandlerForGET: @escaping (_ result: [String:AnyObject]?, _ error: NSError?) -> Void) -> URLSessionDataTask {
        
        /* 1. Set the parameters */
        var newParameters = parameters
        if (isForParse){
            newParameters[UDClient.ParameterKeys.ApiKey] = UDClient.Constants.ParseApiKey as AnyObject?
        }
        
        /* 2/3. Build the URL, Configure the request */
        let request = NSMutableURLRequest(url: UDClient.udacityURLFromParameters(newParameters, withPathExtension: method, isForParse: isForParse))
        
        if (isForParse){
            request.addValue(UDClient.Constants.ParseAppId, forHTTPHeaderField: "X-Parse-Application-Id")
            request.addValue(UDClient.Constants.ParseApiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        }
        
        /* 4. Make the request */
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForGET(nil, NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError("There was an error with your request: \(error!)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                sendError("Your request returned a status code other than 2xx!")
                return
            }
            
             //GUARD: Was there any data returned?
            guard let data = data else {
                //sendError("No data was returned by the request!")
                let userInfo = [NSLocalizedDescriptionKey : "No data was returned by the request!"]
                completionHandlerForGET(nil, NSError(domain: "taskForGetMethod", code: 1, userInfo: userInfo))
                return
            }
 
            //completionHandlerForGET(data, nil)
            /* 5/6. Parse the data and use the data (happens in completion handler) */
            self.convertDataWithCompletionHandler(data, completionHandlerForConvertData: completionHandlerForGET)
        }
        
        /* 7. Start the request */
        task.resume()
        
        return task
    }
    
    // MARK: POST
    
    func taskForPOSTMethod(_ isForParse:Bool = true, parameters: [String:AnyObject], jsonBody: String, completionHandlerForPOST: @escaping (_ result: [String:AnyObject]?, _ error: NSError?) -> Void) -> URLSessionDataTask {
        
        /* 1. Set the parameters */
        var newParameters = parameters
        if (isForParse){
            newParameters[UDClient.ParameterKeys.ApiKey] = UDClient.Constants.ParseApiKey as AnyObject?
        }
        
        /* 2/3. Build the URL, Configure the request */
        let url = UDClient.udacityURLFromParameters(newParameters, withPathExtension: "", isForParse: isForParse)
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if (isForParse){
            request.addValue(UDClient.Constants.ParseAppId, forHTTPHeaderField: "X-Parse-Application-Id")
            request.addValue(UDClient.Constants.ParseApiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        }
        request.httpBody = jsonBody.data(using: String.Encoding.utf8)
        request.log()
        
        /* 4. Make the request */
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            func sendError(_ error: String) {
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForPOST(nil, NSError(domain: "taskForGETMethod", code: 1, userInfo: userInfo))
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError("There was an error with your request: \(error!)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response? */
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                let message = ( (response as? HTTPURLResponse)?.statusCode == 403 ? "User or password are incorrect" : "Your request returned a status code other than 2xx!")
                sendError(message)
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            var newData = data
            if (!isForParse){
                //For Session Post Request, data includes five characters initially that must be dismissed
                let range = Range(5..<data.count)
                newData = data.subdata(in: range)
            }
            
            /* 5/6. Parse the data and use the data (happens in completion handler) */
            self.convertDataWithCompletionHandler(newData, completionHandlerForConvertData: completionHandlerForPOST)
        }
        
        /* 7. Start the request */
        task.resume()
        
        return task
    }
    
    //func taskForPOSTMethod(_ method: String? = nil, isForParse:Bool = true, parameters: [String:AnyObject], jsonBody:String, completionHandlerForPOST: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask {
    
    /*func taskForPOSTMethod(_ method: String? = nil, isForParse:Bool = true, parameters: [String:AnyObject], jsonBody: String, completionHandlerForPOST: @escaping (_ result: AnyObject?, _ error: NSError?) -> Void) -> URLSessionDataTask {
    
        /* 1. Set the parameters */
        var newParameters = parameters
        if (isForParse){
            newParameters[UDClient.ParameterKeys.ApiKey] = UDClient.Constants.ParseApiKey as AnyObject?
        }
        
        /* 2/3. Build the URL, Configure the request */
        let url = UDClient.udacityURLFromParameters(newParameters, withPathExtension: method, isForParse: isForParse)
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        if (isForParse){
            request.addValue(UDClient.Constants.ParseAppId, forHTTPHeaderField: "X-Parse-Application-Id")
            request.addValue(UDClient.Constants.ParseApiKey, forHTTPHeaderField: "X-Parse-REST-API-Key")
        }
        request.httpBody = jsonBody.data(using: String.Encoding.utf8)
        request.log()
        /* 4. Make the request */
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            func sendError(_ error: String){
                print(error)
                let userInfo = [NSLocalizedDescriptionKey : error]
                completionHandlerForPOST(nil, NSError(domain: "taskForPOSTMethod", code: 1, userInfo: userInfo))
            }
            
            /* GUARD: Was there an error? */
            guard (error == nil) else {
                sendError("There was an error with your request: \(error)")
                return
            }
            
            /* GUARD: Did we get a successful 2XX response?*/
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200 && statusCode <= 299 else {
                let message = ( (response as? HTTPURLResponse)?.statusCode == 403 ? "User or password are incorrect" : "Your request returned a status code other than 2xx!")
                sendError(message)
                return
            }
            
            /* GUARD: Was there any data returned? */
            guard let data = data else {
                sendError("No data was returned by the request!")
                return
            }
            
            var newData = data
            if (!isForParse){
                //For Session Post Request, data includes five characters initially that must be dismissed
                let range = Range(5..<data.count)
                newData = data.subdata(in: range)
            }
            
            /* 5/6. Parse the data and use the data (happens in completion handler) */
            self.convertDataWithCompletionHandler(newData, completionHandlerForConvertData: completionHandlerForPOST)
        }
        
        /* 7. Start the request */
        task.resume()
        
        return task
    }*/
    
    // MARK: HELPER
    private func convertDataWithCompletionHandler(_ data: Data, completionHandlerForConvertData: (_ result: [String:AnyObject]?, _ error: NSError?) -> Void) {
        
        var parsedResult: [String: AnyObject]! = nil
        do {
            parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:AnyObject]
        } catch {
            let userInfo = [NSLocalizedDescriptionKey : "Could not parse the data as JSON: '\(data)'"]
            completionHandlerForConvertData(nil, NSError(domain: "convertDataWithCompletionHandler", code: 1, userInfo: userInfo))
        }
        
        completionHandlerForConvertData(parsedResult, nil)
    }
    
    func substituteKeyInMethod(_ method: String, key: String, value: String) -> String? {
        if method.range(of: "{\(key)}") != nil {
            return method.replacingOccurrences(of: "{\(key)}", with: value)
        } else {
            return nil
        }
    }
    
}
