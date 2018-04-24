//
//  ViewController.swift
//  TestAlamofire
//
//  Created by Olya Tilichenko on 20.04.2018.
//  Copyright © 2018 Olya Tilichenko. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let requestManager = RequestManager()
        
        let requestAlamofireDelegate = RequestAlamofireDelegate()
        requestManager.delegate = requestAlamofireDelegate
        
        //let requestURLSessionDelegate = RequestURLSessionDelegate()
        //requestManager.delegate = requestURLSessionDelegate
        
        //let urlString = "https://swift.mrgott.pro/blog.json"
        let urlString = "http://fcm.googleapis.com/fcm/send"
        
        let url = URL(string: urlString)
        let parameters: Parameters = [
            "to" : "c2zxrwtyrfw:APA91bEJ0eFLVWtHCdUNpfz1IY3ytnUPPJ6VBLDhbD_Kn9tDpIaw8kr9ywDME4I_cpHXOoy5AfAcol8EVoqCyWaFhdnkKEPQ04mPdaYwJTgabz2dpHQnItGQVlV-nv_5jt27BeuzzTSL",
            "notification" : [
                "body" : "Hello",
                "title" : "TEST"
            ]
        ]
        
        let headers: HTTPHeaders = [
            "Content-Type" : "application/json",
            "Authorization" : "key=AIzaSyBoajZjZOMWK1BAgHrKCleTunnA6gVwueg"
        ]
        
        requestManager.postRequest(url: url, parameters: parameters, headers: headers)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

