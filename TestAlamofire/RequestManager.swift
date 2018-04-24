//
//  Request.swift
//  TestAlamofire
//
//  Created by Olya Tilichenko on 20.04.2018.
//  Copyright © 2018 Olya Tilichenko. All rights reserved.
//

import Foundation
import Alamofire

class RequestManager {
    
    var delegate: RequestManagerDelegate?
    
    func getRequest(url: URL?) -> () {
        
        if let urlValue = url {
            delegate?.getRequest(url: urlValue)
        }
    }
    
    func postRequest(url: URL?, parameters: Parameters?, headers: HTTPHeaders?) -> () {
        
        if let urlValue = url, let parametersValue = parameters, let headersValue  = headers {
            delegate?.postRequest(url: urlValue, parameters: parametersValue, headers: headersValue)
        }
    }
}

protocol RequestManagerDelegate {
    func getRequest(url: URL)
    func postRequest(url: URL, parameters: Parameters, headers: HTTPHeaders)
}

class RequestAlamofireDelegate: RequestManagerDelegate {

    func getRequest(url: URL) {
        
        request(url).validate().responseJSON { responsejs in
            switch responsejs.result {
            case .success(let value):
                guard let videos = Video.getArray(from: value) else { return }
                print(videos)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func postRequest(url: URL, parameters: Parameters, headers: HTTPHeaders) {
        
        request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { responsejs in
            switch responsejs.result{
            case .success(let value):
                guard let jsonObject = value as? [String: Any] else { return }
                print(jsonObject)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

class RequestURLSessionDelegate: RequestManagerDelegate {
    
    func getRequest(url: URL) {

        let request = URLRequest(url: url)
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: request) {
            (data, response, error) in
            
            guard error == nil else {
                print("error calling GET")
                return
            }
            
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            
            do {
                guard let value = try JSONSerialization.jsonObject(with: responseData, options: [])
                    as? [[String: AnyObject]] else {
                        print("error")
                        return
                }
                guard let videos = Video.getArray(from: value) else { return }
                print(videos)
                
            } catch  {
                print("error trying to convert data to JSON")
                return
            }
        }
        task.resume()
    }
    
    func postRequest(url: URL, parameters: Parameters, headers: [String: String]) {
        
        var request = URLRequest(url: url)
        
        let session = URLSession.shared
        request.httpMethod = "POST"
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch let error {
            print(error.localizedDescription)
        }
        request.allHTTPHeaderFields = headers
        
        let task = session.dataTask(with: request) {
            (data, response, error) in
            
            guard error == nil else {
                print("error calling POST")
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
